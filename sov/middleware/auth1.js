


const jwt=require('jsonwebtoken');
const express = require('express');
auth1=express.Router();



 auth1=async (req,res,next)=>{
    try{
        const token=req.header('token',);
        if(!token) return res.status(401).json({msg:"No auth token, access denied"});
        const isVerified=jwt.verify(token,"passwordKey");
        if(!isVerified) return res.status(401).json({msg:"Token verification failed"});
        req.user=isVerified.id;
        req.token= token;
        next();
    }catch(e){
        res.status(500).json({error: e.message});
    }
}


module.exports = auth1;