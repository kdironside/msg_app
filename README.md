This app demonstrates one approach to a simple, one-to-one internal messaging process. It could easily be modified to adopt the look and feel of a Facebook-style messaging system. That was the original objective, however, for demonstration purposes, I decided to leave it closer to a traditional Rails nested resources structure as the emphasis of this demo is understanding how an internal messaging system might be started.

This messaging system could also be modified to forward emails though ActionMailer to say, a gmail account.

It uses Rails 3.2.8, Sqlite3, and twitter-bootstrap-rails to make the presentation nice and tidy.

The database structure is: User has many conversations; Conversation has many messages. Each User has their own set of conversations/messages and are therefore independently maintained by each user. That means whenever a new message is "sent" a message row is stored for both the "sender" and the "receiver". Yes, two sets of data, each separate and independent of the other. Ditto for conversations. 

If one user deletes their entire conversation, a subsequently sent/received message requires the app to build a new conversation record along with the corresponding message.

If a user recipient is deleted, this will be made evident to the sender, however, the corresponding sender's previous conversation and messages remain until he/she decides to delete them.  