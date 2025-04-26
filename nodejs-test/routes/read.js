const express = require('express');
const mysql = require('mysql2');
const router = express.Router();

// 데이터베이스 연결 설정 (변경 없음)
const connection = mysql.createConnection({
  host: '20.249.216.72',
  user: 'admin',
  password: 'admin',
  database: 'ynhouse',
});

// 데이터베이스 연결 (변경 없음)
connection.connect((err) => {
  if (err) {
    console.error('데이터베이스 연결 실패:', err.stack);
    return;
  }
  console.log('데이터베이스에 성공적으로 연결되었습니다.');
});

// Swagger 문서 (변경 없음)
/**
 * @swagger
 * paths:
 *  /raw:
 *    get:
 *      summary: "입력 값에 맞는 자재 데이터 출력"
 *      description: "서버에 요청"
 *      parameters:
 *        - in: query
 *          name: material_name
 *          required: true
 *          description: "자재 이름 검색"
 *          schema:
 *            type: string
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
 *                      name:
 *                        type: string
*/

let responseData = {
  rawData: [],
  materialData: []
};

router.get('/', (req, res) => {
    const name = req.query.material_name;

    // 필수 파라미터 검증 추가 (기존 변수명 유지)
    if (!name) {
        return res.status(400).json({ error: "material_name 파라미터 필수" });
    }

    console.log(name);

    connection.query(`SELECT raw_material_id, material_name, standard, material_price FROM raw WHERE material_name LIKE ? `,[`%${name}%`], (err, results) => {
      if (err) {
        console.error('쿼리 실행 오류:', err.stack);
        responseData.rawData = []; // 오류 시 빈 배열 할당
      } else {
        responseData.rawData = results;
      }     
      
      connection.query(`SELECT material_id, material_name, standard, material_price FROM material WHERE material_name LIKE ?`, [`%${name}%`], (err, results2) => {
        if (err) {
          console.error('쿼리 실행 오류2:', err.stack);
          responseData.materialData = []; // 오류 시 빈 배열 할당
        } else {
          responseData.materialData = results2;
        }

        res.status(200).json(responseData);
      });
    }); 
});
  
module.exports = router;
