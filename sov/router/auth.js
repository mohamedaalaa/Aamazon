



const express = require('express');
const bcrybtjs=require('bcryptjs');
const { default: mongoose } = require('mongoose');
const User = require('../models/user.js');
const app = express();
const jwt=require('jsonwebtoken');
const auth1 = require('../middleware/auth1.js');


const authRouter=express.Router();

authRouter.post("/api/signup", async (req,res)=>{

    try{
        const {name,email,password} = req.body;
        const existingUser =await User.findOne({ email });
        if(existingUser){
            return res.status(400).json({msg: "User with same email already exists!"});
        }

        const hashedPassword=await bcrybtjs.hash(password,8);

        let user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    }catch(e){
        res.status(500).json({error: e.message});
    }
});


//login

authRouter.post("/api/signin", async (req,res)=>{
    try{
        const {email,password}=req.body;

        const user=await User.findOne({email});
        if(!user){
            res.status(400).json({msg:"User with this email is not existwd"});
        }
        const isMatch=await bcrybtjs.compare(password,user.password);
        if(!isMatch){
            res.status(400).json({msg:"password is incorrect"});
        }

        const token=jwt.sign({id:user._id},"passwordKey");
        res.json({token,  ...user._doc});

    }catch(error){
        res.status(500).json({error: e.message});
    }
});


//check of token is valid

authRouter.post("/isTokenValid", async (req,res)=>{
    try{
        const token=req.header('token',);
        if(!token) return res.json(false);
        const isVerified=jwt.verify(token,"passwordKey");
        if(!isVerified) return res.json(false);
        const user=await User.findById(isVerified.id);
        if(!user) return res.json(false);
        return res.json(true);
    }catch(error){
        res.status(500).json({error: e.message});
    }
});

authRouter.get('/', auth1, async (req,res)=>{
    const user=await User.findById(req.user);
    res.send({...user._doc,token:req.token});
})
module.exports = authRouter;

