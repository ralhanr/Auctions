string public item;
uint public auctionEnd;
address public maxBidder;
uint public maxBid;
bool public ended;


event bidAccepted(address _maxbidder, uint _maxBid);

function timedAuction(string _item, uint _durationMins) public {
    auctionEnd = now + (_durationMins * 1 minutes);
    item = _item;
}

function bid () payable{
    require(now<auctionEnd);
    require(msg.value > maxBid);
        if(maxBidder != 0) {
        pendingWithdrawls[maxBidder] = maxBid;
        }
    maxBidder = msg.sender;
    maxBid = msg.value;
    bidAccepted(maxBidder, maxBid);
}
function end() public ownerOnly {
    require(!ended);
    require (now >= auctionEnd );
    ended = true;
    auctionComplete(maxBidder, maxBid);

   pendingWithdrawls[owner] = maxBid;

}

}
