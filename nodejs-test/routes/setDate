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
 *  /test:
 *    get:
 *      summary: "특정 날짜 범위 내의 데이터 조회"
 *      description: "시작일과 종료일을 입력하면 해당 기간의 데이터를 조회합니다."
 *      parameters:
 *        - in: query
 *          name: startDate
 *          required: true
 *          description: "조회할 시작 날짜 (YYYY-MM-DD)"
 *          schema:
 *            type: string
 *            format: date
 *        - in: query
 *          name: endDate
 *          required: true
 *          description: "조회할 종료 날짜 (YYYY-MM-DD)"
 *          schema:
 *            type: string
 *            format: date
 *      responses:
 *        200:
 *          description: "조회 성공"
 *          content:
 *            application/json:
 *              schema:
 *                type: array
 *                items:
 *                  type: object
 *                  properties:
 *                    count:
 *                      type: integer
 *                      example: 2
 *        400:
 *          description: "잘못된 요청 (날짜 입력 오류)"
 *        500:
 *          description: "서버 오류"
 */


router.get('/', (req, res) => {
  const { startDate, endDate } = req.query;

  if (!startDate || !endDate) {
      return res.status(400).json({ error: "startDate와 endDate를 입력하세요." });
  }

  const query = `SELECT COUNT(*) AS count FROM test_construction WHERE due_date BETWEEN ? AND ?`;
  connection.query(query, [startDate, endDate], (err, results) => {
      if (err) {
          console.error('DB 조회 오류:', err);
          return res.status(500).json({ error: "서버 오류" });
      }
      res.json({ count: results[0].count });
  });
});

module.exports = router;
