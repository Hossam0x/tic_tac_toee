// import modules
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const app = express();
const port =process.env.port || 3000
var server = http.createServer(app);
const Room = require('./models/room.js');
const { Socket } = require('socket.io');
const { index } = require('./models/player.js');
var io = require('socket.io')(server);


// middle ware
app.use(express.json());

const DB = "mongodb+srv://hossamrashed17:test123@cluster0.tsvxg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

io.on('connection', (socket)=>{
  console.log(`User connected: ${socket.id}`)
    socket.on('createRoom' , async({nickname})=>{
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
    socket.on('joinRoom',async({nickname , roomId})=>{
      console.log(nickname);
      try{
        if(!roomId.match(/^[0-9a-fA-F]{24}$/)){
          console.log("a7ooo1")
          socket.emit('errorOccured','Please enter a valid room Id');
          return;
        }
        let room = await Room.findById(roomId);
        if(room.isJoin){
          let player ={
            nickname , 
            socketID:socket.id,
            playerType : 'O',
          }
          socket.join(roomId);
          room.players.push(player);
          room.isJoin = false ;
          room = await room.save();
          io.to(roomId).emit("joinRoomSuccess" , room);
          io.to(roomId).emit("udatePlayers" , room.players);
          io.to(roomId).emit("updateRoom" , room);
          console.log("a7ooo")
    
        }else{
          socket.emit('errorOccured','the game is in progress , try again later');
    
        }
    
      }
      catch (e){
        
        console.log('Error joining room', e);
      }
    });

    socket.on('tap' ,async({index , roomId}) =>{
      try{  
          let room = await Room.findById(roomId);

          let choice = room.turn.playerType; // x or o
          if(room.turnIndex == 0){
            room.turn = room.players[1] ;
            room.turnIndex = 1 ;
          }else{
            room.turn = room.players[0] ;
            room.turnIndex = 0 ;
          }
          room = await room.save() ;
          io.to(roomId).emit('tapped' , {
            index ,
            choice,
            room ,
          })
      }catch (e){
        console.log(e);
      }
    });

    socket.on('winner' , async({winnerSocketId , roomId}) =>{
      try{
        let room = await Room.findById(roomId);
        let player = room.players.find((palyerr) =>palyerr.socketID == winnerSocketId);
        player.Points+=1;
        room = await room.save();
        if(player.Points >= room.maxRounds){
          io.to(roomId).emit("endGame" , player);
        }else{
          io.to(roomId).emit("pointIncrease" , player);
        }

      }catch (e){
        console.log(e);
      }
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