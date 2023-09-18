import * as Clickhouse from '@clickhouse/client' // or '@clickhouse/client-web'
import express from 'express';
import * as parser from 'body-parser';
import axios from 'axios';
import 'dotenv/config'

const TOKENS = JSON.parse(process.env.ACCESS_TOKENS.replace(/\\/g, ''));
const app = express();

app.use(parser.urlencoded({ extended: false }));
app.use(parser.json({ limit: '10mb' }));
app.use((err: any, req: any, res: any, next: any) => {
  console.error(err);
  if (err.message === 'access denied') {
    res.status(403).json({ err: err.message });
  } else {
    res.status(500).json({ err: 'unknown' });
  }
});

(async () => {    
  const clickhouse = Clickhouse.createClient({
    host: process.env.CLICKHOUSE_HOST,
    username: process.env.CLICKHOUSE_USERNAME,
    password: process.env.CLICKHOUSE_PASSWORD,  
    database: process.env.CLICKHOUSE_DATABASE,  
    compression: {
      response: true,
      request: true
    }
  })
  
  let server = app.listen(process.env.SERVER_PORT, () => {
    let info: any = server.address();
    let host = info.address;
    let port = info.port;
    console.log('IR Notification API server listening at http://%s:%s', host, port);    
    app.post('/api/events', async (req, res)=>{     
      if(TOKENS.indexOf(req.get('x-api-key')) >= 0){
        await clickhouse.insert({
          table: process.env.CLICKHOUSE_TABLE,
          values: [ req.body ],
          format: 'JSONEachRow',
        })
        res.json({status: true})
      }else{
        res.json({error: 'x-api-key incorrect'})
      }
    });
  });
})();
