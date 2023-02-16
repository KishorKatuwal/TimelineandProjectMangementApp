//importing packages
const express = require('express');
const mongoose = require('mongoose');
const {Server} = require('socket.io');
const {createServer} = require('http');

//importing from other files
const authRouter = require("./routes/auth");
const userRouter = require('./routes/user');
const adminRouter = require('./routes/admin');

//importing discussion Model
const  Discussion  = require('./models/discussion');

//initialize
const PORT= 3000;
const app = express();
const DB = "mongodb+srv://kishor:laptop@cluster0.lp56wr2.mongodb.net/?retryWrites=true&w=majority"
const httpServer = createServer(app);
const io = new Server(httpServer);


//middleware
app.use(express.json());
app.use(authRouter);
app.use(userRouter);
app.use(adminRouter);

//connecting to the database
mongoose.set("strictQuery", false);
mongoose.connect(DB).then(()=>{
    console.log("Connection established");
}).catch((e)=>{
    console.log(e);
});


io.on("connection",(socket)=>{
    socket.join("discussion_group");
    console.log("Chat backend connected");
    socket.on("send", (msg)=>{
        console.log(msg);
//        socket.emit("sendMsgServer", {...msg, messageTime:"otherTime"})
    io.to("discussion_group").emit("sendMsgServer", {...msg, messageTime:"otherTime"});
       let discussion = new Discussion({
       message:msg.message,
       messageTime:msg.messageTime,
       userId:msg.userId,
       userName:msg.userName,
       userGroup:msg.userGroup,
       userYear:msg.userYear});
       discussion.save((error) => {
         if (error) {
           console.error(error);
         } else {
           console.log("Message saved successfully.");
         }
       });
    });
});



//creating an API
httpServer.listen(PORT, "0.0.0.0", ()=>{
 console.log(`Connected at port ${PORT}`);
});

