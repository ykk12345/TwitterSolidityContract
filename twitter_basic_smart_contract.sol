//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;


contract Twitter
{
    struct Tweet{
      uint256 id;
      address author;
      string content;
      uint256 timestamp;
      uint256 likes;
    }

  mapping(address => Tweet[]) public Tweets; // address is the mapping key
uint16 public MAX_TWEET_LENGTH = 280;
address public owner;

event TweetCreated(uint256 indexed id,address author, string content,uint256 timestamp);
   event TweetLiked(address liker, address tweetAuthor, uint256 tweetId,uint256 newLikeCount);
   event TweetUnliked(address unliker,address tweetAuthor,uint256 tweetId,uint256 newUnlikeCount);

   constructor(){
    owner = msg.sender;
   }

modifier onlyOwner(){
    require(msg.sender==owner,"You are not the owner");
    _;
   }

function changeTweetLength(uint16 newTweetLength) public onlyOwner{
    MAX_TWEET_LENGTH = newTweetLength;

  }

  function createTweet(string memory _tweet) public { // storing the _tweet in temporary memory
         require(bytes(_tweet).length<=MAX_TWEET_LENGTH,"Tweet length is too long!"); // fixing the length of the tweet to 280 character
    Tweet memory newTweet = Tweet({
     id:Tweets[msg.sender].length,
      author : msg.sender,
      content : _tweet,
      timestamp: block.timestamp,
      likes : 0
    });
    Tweets[msg.sender].push(newTweet);// saving the tweets in the mapping
   // emiting the event
    emit TweetCreated(newTweet.id,newTweet.author,newTweet.content,newTweet.timestamp);
  }
 function likeTweet(address author, uint256 id) external{
    require(Tweets[author][id].id==id,"Tweet does not exist");
    // above require its to make sure that you like the correct tweet
    Tweets[author][id].likes++;
 // emiting the event
    emit TweetLiked(msg.sender,author,id,Tweets[author][id].likes);
  }
function unlikeTweet(address author, uint256 id) external{
    require(Tweets[author][id].id==id,"Tweet does not exist");
    require(Tweets[author][id].likes>0,"Tweet has no likes");
    Tweets[author][id].likes--;

    // emiting the event
    emit TweetUnliked(msg.sender,author,id,Tweets[author][id].likes);
  }
  function getTweet(uint _i) public view returns(Tweet memory){
    return Tweets[msg.sender][_i];
  }
  
  function getallTweets(address _owner) public view returns(Tweet[] memory)
  {
    return Tweets[_owner];
  }
}
