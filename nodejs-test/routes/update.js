const express = require('express');
const mysql = require('mysql2');
const router = express.Router();

// 데이터베이스 연결 설정
const connection = mysql.createConnection({
  host: '20.249.216.72',  // 데이터베이스 서버 주소
  user: 'admin',  // MySQL 사용자 이름
  password: 'admin',  // MySQL 비밀번호
  database: 'ynhouse',  // 사용할 데이터베이스 이름
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
 *  /update:
 *   post:
 *     tags: [Raw Materials]
 *     summary: 원자재 데이터 업데이트
 *     description: 기존 원자재 정보를 업데이트합니다.
 *     consumes:
 *       - application/json
 *     produces:
 *       - application/json
 *     parameters:
 *       - in: body
 *         name: body
 *         description: 업데이트할 원자재 데이터
 *         required: true
 *         schema:
 *           type: object
 *           required:
 *             - id
 *           properties:
 *             raw_material_id:
 *               type: integer
 *               description: 원자재 고유 ID
 *               example: 44739
 *             material_name:
 *               type: string
 *               description: 원자재 이름
 *               example: "히타"
 *             standard:
 *               type: string
 *               description: 규격
 *               example: "7kw"
 *             material_price:
 *               type: number
 *               format: integer
 *               description: 가격
 *               example: 700000
 *     responses:
 *       200:
 *         description: 성공적으로 업데이트됨
 *         schema:
 *           type: object
 *           properties:
 *             success:
 *               type: boolean
 *               example: true
 *             updatedData:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                 material_name:
 *                   type: string
 *                 standard:
 *                   type: string
 *                 material_price:
 *                   type: number
 *       400:
 *         description: 잘못된 요청 (ID 누락 등)
 *       404:
 *         description: 해당 ID의 원자재를 찾을 수 없음
 *       500:
 *         description: 서버 내부 오류
 */

// 실제 API 구현
router.post('/', (req, res) => {
    const { raw_material_id, material_name, standard, material_price } = req.body;

    // MySQL 업데이트 쿼리
    const query = `UPDATE raw SET material_name = ?, standard = ?, material_price = ? WHERE raw_material_id = ?`;
    const params = [material_name, standard, material_price, raw_material_id];
    
    console.log(params);

    connection.query(query, params, (error, results) => {
        if (error) {
            console.error('MySQL 업데이트 오류:', error);
            return res.status(500).json({ error: "데이터베이스 업데이트 실패" });
        }
    
        // 영향을 받은 행이 없으면 404 반환
        if (results.affectedRows === 0) {
            return res.status(404).json({ error: "해당 ID의 원자재를 찾을 수 없습니다" });
        }
    
        // 업데이트된 데이터 조회
        const selectQuery = `SELECT * FROM raw WHERE raw_material_id = ?`;
        connection.query(selectQuery, [raw_material_id], (selectError, selectResults) => {
            if (selectError || selectResults.length === 0) {
                console.error('업데이트된 데이터 조회 오류:', selectError);
                return res.status(200).json({ 
                    success: true,
                    message: "업데이트 성공했지만 업데이트된 데이터를 가져오지 못했습니다"
                });
            }
            
            // 성공 응답
            res.status(200).json({
                success: true,
                updatedData: selectResults[0]
            });
        }); // selectQuery 콜백 닫기
    }); // updateQuery 콜백 닫기
}); // router.post 닫기

module.exports = router;
