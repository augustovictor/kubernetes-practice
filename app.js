const express = require('express');
const mongo   = require('mongodb').MongoClient;
const { ObjectID } = require('mongodb');

const app     = express();
const DB_URI  = process.env.MONGODB_URI || 'mongodb://localhost:27017/node-app-kubernetes';


const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    const requestObj = { _id: new ObjectID(), request: `${new Date().getTime()} ${req.get('User-Agent')}` };
    mongo.connect(DB_URI, (err, db) => {
        if(err) console.log(err);
        console.log(`CONNECTED SUCCESSFULLY TO ${ DB_URI }`);
        db.collection('requests').insertOne(requestObj, (err, insertedRequest) => {
            if(err) {
                res.send(err).end();
            } else {
                res.send(`Request ${ insertedRequest.ops[0]._id } stored! =D Enter /requests to see all.`).end();
            }
        })
        db.close();
    });
});

app.get('/requests', (req, res) => {
    mongo.connect(DB_URI, (err, db) => {
        if(err) console.log(err);
        console.log(`CONNECTED SUCCESSFULLY TO ${ DB_URI }`);
        db.collection('requests').find({}).toArray((err, requests) => {
            if(err) {
                res.send(err).end();
            } else {
                res.json(requests).end();
            }
        });
        db.close();
    });
})

app.listen(port, () => console.log(`RUNNING ON PORT ${ port }`));