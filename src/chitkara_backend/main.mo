import Text "mo:base/Text";
import RBTree "mo:base/RBTree";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

actor {
  var question: Text = "What is your favorite programming Language?";
  var votes: RBTree.RBTree<Text, Nat> = RBTree.RBTree(Text.compare);
  

  public query func getQuestion() : async Text {
    question
  };

  public query func getVotes() : async [(Text, Nat)] {
    // Iter -> pointer like DS allowing for DS values to be parsed one by one in a sequential manner.
    // Iter.toArray() -> converts Iter<(Text,Nat)> to [(Text,Nat)];
    Iter.toArray(votes.entries());
  };

  public func vote(entry: Text): async [(Text,Nat)] {
    // Check if the entry already has votes.
    // Note that "votes_for_entry" is of type ?Nat. This is because:
    // * If the entry is in the RBTree, the RBTree returns a number.
    // * If the entry is not in the RBTree, the RBTree returns `null` for the new entry.
    let votes_for_entry :?Nat = votes.get(entry);

    let current_votes_for_entry: Nat = switch votes_for_entry {
      case null 0;
      case (?Nat) Nat;
    };

    votes.put(entry, current_votes_for_entry + 1);

    Iter.toArray(votes.entries());
  };

  public func resetVotes() : async [(Text,Nat)] {
    votes.put("Motoko", 0);
    votes.put("Rust", 0);
    votes.put("Typescript", 0);
    votes.put("Python", 0);
    Iter.toArray(votes.entries());
  }
}