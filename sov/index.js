




const express = require('express');
const mongoose=require('mongoose');
const authRouter=require("./router/auth");
var cors = require("cors");
// const User = require('../models/user.js');

const DB="mongodb+srv://mohamed:mhmd123@cluster0.sqozuqm.mongodb.net/?retryWrites=true&w=majority";
const app = express();
const port=3000;
const http = require('http');
const server = http.createServer(app);

// app.use(cors());
app.use(express.json());
app.use(authRouter);

mongoose.connect(DB,{useNewUrlParser: true }).then(()=>{
    console.log("Connection done successfully to srver")
});

server.listen(port, () => {
    console.log('listening on *: '+ port);
  });