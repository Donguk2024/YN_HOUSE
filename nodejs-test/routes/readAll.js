const express = require('express');
const mysql = require('mysql2');
const router = express.Router();

// 데이터베이스 연결 설정
const connection = mysql.createConnection({
  host: '20.249.216.72',  // 데이터베이스 서버 주소
  user: 'admin',  // MySQL 사용자 이름
  password: 'admin',  // MySQL 비밀번호
  database: 'ynhouse'  // 사용할 데이터베이스 이름
});

// 데이터베이스 연결
connection.connect((err) => {
  if (err) {
    console.error('데이터베이스 연결 실패:', err.stack);
    return;
  }
  console.log('데이터베이스에 성공적으로 연결되었습니다.');
});

/**
 * @swagger
 * paths:
 *  /sample:
 *    get:
 *      summary: "유저 데이터 전체조회"
 *      description: "서버에 요청"
 *      tags: [Users]
 *      responses:
 *          200:
 *            description: "유저 데이터 반환"
 *            content:
 *              application/json:
 *                schema:
 *                  type: array
 *                  items:
 *                    type: object
 *                    properties:
 *                      id:
 *                        type: integer
 *                      name:
 *                        type: string
 */

router.get('/', (req, res) => {
  connection.query('SELECT * FROM test', (err, results) => {
    if (err) {
      console.error('쿼리 실행 오류:', err.stack);
      return;
    }else{
      res.json(results);
    }
  });
});

module.exports = router;
