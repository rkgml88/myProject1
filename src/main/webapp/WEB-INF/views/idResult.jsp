<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="resources/css/nav.css">
    <link rel="stylesheet" type="text/css" href="resources/css/footer.css">
    <link rel="stylesheet" type="text/css" href="resources/css/idResult.css">
    <title>IN COFFEE | 아이디 찾기</title>
    <style>
        section{
            padding-top: 110px;
            overflow-x: hidden;
        }
        #contain{
            padding: 3% 20% 10%;
            
        }
        #category{
		    color: rgb(16, 15, 80);
		    letter-spacing: 1.5px;
		    font-size: 20px;
		    text-align: center;
		    width: 100%;
		}
        #main{
            border: 2px solid rgb(16, 15, 80);
            padding: 80px 70px 40px;
        }
        #resultWrap{
            border: 1px solid #ddd;
            padding: 20px;
            box-sizing: border-box;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }
        #resultID{
            text-align: center;
        }
        #bottomRow{
            display: flex;
            justify-content: center;
            margin-top: 40px;
            gap: 4px;
        }
        #login, #findPW{
            padding: 10px;
            border-radius: 5px;
            border: none;
            color: white;
            background-color: rgb(16, 15, 80);
            box-shadow: 0 2px 5px rgba(0,0,0,0.3);
            font-family: 'HANAMDAUM';
            cursor: pointer;
            font-size: 15px;
        }
    </style>
</head>
<body>
<div id="wrap">
<!-- 카테고리 -->
<jsp:include page="/WEB-INF/views/nav.jsp" />
    <section>
    	<div id="contain">             
            <div id="category">
                <h1>아이디 찾기</h1>
            </div>
            <div id="main">
                <div id="resultWrap">
                    <p id="resultID">${username}</p>
                </div>
                <div id="bottomRow">
                    <a href="login" id="login">로그인</a>
                    <a href="findPW" id="findPW">비밀번호 변경</a>
                </div>
            </div>
    	</div>    
    </section>
    <!-- footer -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />s
</div>
</body>
</html>