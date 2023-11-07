//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;


contract Twitter
{
    struct Tweet{
      address author;
      string content;
      uint256 timestamp;
      uint256 likes;
    }

  mapping(address => Tweet[]) public Tweets; // address is the mapping key
   uint16 constant MAX_TWEET_LENGTH = 280;
  function createTweet(string memory _tweet) public { // storing the _tweet in temporary memory
         require(bytes(_tweet).length<=MAX_TWEET_LENGTH,"Tweet length is too long!"); // fixing the length of the tweet to 280 character
    Tweet memory newTweet = Tweet({
      author : msg.sender,
      content : _tweet,
      timestamp: block.timestamp,
      likes : 0
    });
    Tweets[msg.sender].push(newTweet);// saving the tweets in the mapping
  }

  function getTweet(uint _i) public view returns(Tweet memory){
    return Tweets[msg.sender][_i];
  }
  
  function getallTweets(address _owner) public view returns(Tweet[] memory)
  {
    return Tweets[_owner];
  }
}
