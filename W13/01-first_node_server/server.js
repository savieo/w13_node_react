// 1- create a folder for project
// 2-npm init (use your own or use default)
//3- npm install --save-dev eslint eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint-plugin-standard eslint-config-standard
//4- npm install express
'use strict'
//force variable declaration before they can  be usedn
var a=3
var b=4
var c
c=a+b
console.log(c)
// first do npm install express
//this is the express firmware for the Node web server
const express=require('express')
const app=express()

//ROUTES-----------------
//Home page response
app.get('/',function(request,response){
    response.sendFile(__dirname+'/index.html')

    var fs=require('fs');
    fs.readFile('home_count.txt','utf8',function(err,data){
        if (err) throw err;
        console.log('file content ='+data);

        //convert to int and increment the value
        var data_int = parseInt(data)+1;
        console.log('new count='+data_int);

        //write count to file
        fs.writeFile('home_count.txt',data_int,function(err){
            if(err) throw err;
            console.log('Replaced');
        });
    })

})


app.get('/login',function(request,response){
    response.send("this is the login page")
})
const DB=require('./dao')
DB.connect()
DB.query('select * from nodepg', [], (result) => {
    console.log('Number of rows in table: ' +result.rowCount)
    console.log(result.rows)
})

DB.query('select id, stringfield from nodepg where id>$1',[3],(result) =>{
    console.log('Number of rows in table:' +result.rowCount)

    console.log(result.rows)
}
)
//DB.disconnect()
//server all files in public.xml without any further process
app.use(express.static('public_html'))
//use ctrl + c stop listening
app.listen(3001,function(){
    console.log('server listening to port 3001')
})
const dt = require('./myfirstmodule')
console.log(dt.myDateTime())

// const { Client } = require('pg')

// const DB = new Client({
//     host: 'localhost',
//     port: 5432,
//     database: 'DB_test',
//     user: 'postgres',
//     password: 'postgres'
// })

// DB.connect((error) => {
//     if (error) {
//         console.error('connection error', error.stack)
//     } else {
//         console.log('connected')
//     }
// })

// DB.query('SELECT * FROM nodepg', (error, db_reply) => {
//     if (error) {
//         throw error
//     }

//     console.log(db_reply)
//     DB.end()
// })
