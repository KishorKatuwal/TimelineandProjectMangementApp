//importing packages
const express = require('express');
const mongoose = require('mongoose');

//importing from other files
const authRouter = require("./routes/auth");
const userRouter = require('./routes/user');

//initialize
const PORT= 3000;
const app = express();
const DB = "mongodb+srv://kishor:laptop@cluster0.lp56wr2.mongodb.net/?retryWrites=true&w=majority"

//middleware
app.use(express.json());
app.use(authRouter);
app.use(userRouter);

//connecting to the database
mongoose.set("strictQuery", false);
mongoose.connect(DB).then(()=>{
    console.log("Connection established");
}).catch((e)=>{
    console.log(e);
});


//creating an API
app.listen(PORT, "0.0.0.0", ()=>{
 console.log(`Connected at port ${PORT}`);
});

