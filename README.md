# CLI Chess

## Summary
This is the final project for the Ruby sections of TheOdinProject.  This is a two-player chess game played in the command line.  It was built using OOP principles and fully tested via Rspec.

This was the largest project I've worked on up to that point and trying to keep everything organized was the biggest struggle for me.  By keeping everything encapsulated I was able to refactor without causing bugs across the entire application.  The part which took me the longest was figuring out how to determine check and checkmate.  I solved this issue by writing a function which checks whether a space is being attacked by any piece or not, and checking if the king could move into any squares not being attacked.  

## Pictures
![rubychess3](https://user-images.githubusercontent.com/38001874/208808389-e7e23a91-78e1-4cb0-bad1-3bda9d58a71f.png)

###### In check
![check](https://user-images.githubusercontent.com/38001874/208808692-41cf7a55-ce0c-4f7a-b8be-f73f1ea2a1fe.png)

## Technologies Used
- Ruby
- Rspec
