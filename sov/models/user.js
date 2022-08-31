


const mongoose=require('mongoose');


const userSchema=mongoose.Schema({
    name:{
        required:true,
        type:String,
        trim:true
    },
    email:{
        required:true,
        type:String,
        trim:true,
        validate:{
            validator:(value)=>{
                const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
              
             return value.match(re);
            },
            message:"Please enter a valid email address",
        }
    },
    password:{
        required:true,
        type:String,
        validate:{
            validator:(value)=>{
                return value.length > 6;
            },
            message:"Password must contain at least 6 chars",
        }
    },
    address:{
        type:String,
        default:'',
    },
    type:{
        type:String,
        default:'user',
    }
} ,{
    collection: 'userInfo'
  });

const User= mongoose.model('userInfo', userSchema);
module.exports=User;