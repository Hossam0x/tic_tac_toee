// import modules
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const port =process.env.port || 3000
var server = http.createServer(app);
const Room = require('./models/room.js');
var io = require('socket.io')(server);


// middle ware
app.use(express.json());

const DB = "mongodb+srv://hossamrashed17:test123@cluster0.tsvxg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

io.on('connection', (socket)=>{
  console.log(`User connected: ${socket.id}`)
    socket.on('createRoom' , async({nickname})=>{
      console.log("a7a tany");
        console.log(nickname);
         // room is created(server side)
      try{
        let room = new Room();
        let player = {
           socketID:socket.id ,
           nickname,
           playerType : 'X',

        };
        room.players.push(player);
        room.turn=player;
        room= await room.save();
        console.log(room);

        const roomId = room._id.toString();
        
        socket.join(roomId);
        // io -> send data to everyone
        //socket -> sending data to yourself
         io.to(roomId).emit("createRoomSuccess" , room);
        // tell our client tat room has been created
        //go to the next page
      }catch(e){
        console.log('Error creating room', e);
      }

        //player is store in the room(server side)


        // player is taken to the next screen(clinet side)
    });
});
mongoose.connect(DB).then(()=>{
    console.log('Database Connected...');
}).catch((e)=>{
    console.log('Error connecting to DB', e);
})
// promise in js = Future in Dart
server.listen(port , '0.0.0.0', ()=>{
    console.log(`Server running on port ${port}`);
});