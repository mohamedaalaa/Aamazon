
const jwt = require('jsonwebtoken');
const User = require('../models/user');
const express = require('express');
 admin=express.Router();


 admin = async (req, res, next) => {
    try {
        const token = req.header('token',);
        if (!token) return res.status(401).json({ msg: "No auth token, access denied" });
        const isVerified = jwt.verify(token, "passwordKey");
        if (!isVerified) return res.status(401).json({ msg: "Token verification failed" });
        const user= await User.findById(isVerified.id);
        if(user.type == "user" || user.type == "seller"){
            return res.status(401).json({msg:"You are ot admin"});
        }
        req.user = isVerified.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
}
module.exports=admin;