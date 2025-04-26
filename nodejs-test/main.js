const express = require('express');
const swaggerUi = require('swagger-ui-express');
const swaggerJSDoc = require('swagger-jsdoc');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3010;

// CORS 설정
app.use(cors());

app.use(bodyParser.json()); // JSON 형식의 body 파싱
app.use(bodyParser.urlencoded({ extended: true })); // URL-encoded 형식 파싱

// Swagger 설정
const swaggerOptions = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'My API',
      version: '1.0.0',
      description: '한글이 포함',
    },
    servers: [
      {
        url: 'http://20.249.216.72:3010',
        description: 'Production server',
      },
    ],
  },
  apis: ['./routes/*.js'], // routes 폴더 안의 모든 파일에서 Swagger 문서 추출
};

// Swagger 문서 생성 및 적용
const swaggerSpec = swaggerJSDoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// 라우트 추가
const readAllRoute = require('./routes/readAll');
app.use('/readAll', readAllRoute);

// 라우트 추가
const dateRoute = require('./routes/setDate');
app.use('/setDate', dateRoute);

// 라우트 추가
const readRoute = require('./routes/read');
app.use('/read', readRoute);

const updateRoute = require('./routes/update');
app.use('/update', updateRoute);

const deleteRoute = require('./routes/delete');
app.use('/delete', deleteRoute);

const createRoute = require('./routes/create');
app.use('/create', createRoute);

// 서버 실행
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running at http://20.249.216.72:${PORT}/api-docs`);
});
