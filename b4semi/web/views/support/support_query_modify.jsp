<%@page import="com.sun.org.omg.CORBA.OpDescriptionSeqHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.b4.model.vo.*, java.util.*, static common.DateFormatTemplate.getTillDate" %>
<%@ include file="/views/common/header.jsp"%>
<%
	QueryBoard qb = (QueryBoard)request.getAttribute("queryBoard");
	List<Images> imgList = (List<Images>)request.getAttribute("imgList");
%>

    <style> 
        .query-form-wrapper
        {
            width: 1024px;
            font-family: 'Noto Sans KR';
            font-size: 14px;
            margin-top: 100px;
        }
        .query-form input
        {
            font-family: 'Noto Sans KR';
            padding: 5px;
            height: 30px;
            box-sizing: border-box;
            border: 1px solid #ccc;
        }
        .query-form input:focus
        {
            outline: none;
        }
        .query-form-header
        {
            font-size: 21px;
            margin: 25px 0;
        }
        .query-form
        {
            display: flex;
            flex-flow: column nowrap;
            border-top: 2px solid rgb(42, 71, 114);
        }
        .query-form > div
        {
            display: flex;
        }
        .query-form > div > div:first-of-type
        {
            background-color: rgb(245, 245, 245);
        }
        .query-form > div > div:first-of-type{flex: 1 1 0; justify-content: center;}
        .query-form > div > div:nth-of-type(2){flex: 7 1 0; display: flex;}
        .query-form > div > div 
        {
            display: flex;
            padding: 15px 0 15px 10px;
            align-items: center;
            border-bottom: 1px solid #ccc;
        }
        .query-form-order-seq input[type="button"]
        {
            width: 100px;
            height: 30px;
            margin-left: 10px;
            color: white;
            border: none;
            border-radius: 2px;
            font-size: 12px;
            background-color: rgb(42, 71, 114);
            cursor: pointer;
        }
        .query-form-order-seq input[type="button"]:hover
        {
            background-color: rgb(62, 91, 134);
        }
        .query-form-title input{width: 100%;}
        .query-form-email input{background-color: #eee;}
        .query-form-email label{margin: 0 10px;}
        .query-form-content textarea
        {
            height: 300px;
            width: 100%;
            resize: none;
            border: 1px solid #ccc;
            padding: 5px;
        }
        .query-form-content textarea:focus
        {
            outline: none;
        }
        .added-image-box
        {
            width: 82px;
            height: 82px;
            margin-right: 10px;
        }
        .added-image-box > img
        {
            width: 100%;
            height: 100%;
        }
        .image-upload-container
        {
            width: 80px;
            height: 80px;
            border: 1px dotted gray;
            position: relative;
        }
        .image-upload-container:hover
        {
            background-color: #eee;
        }
        .image-upload-container > input
        {
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        .image-upload-container > span
        {
            font-size: 20px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
        }
        .query-button-set
        {
            align-self: flex-end;
        }
        .query-button-set input[type="submit"]
        {
            color: white;
            background-color: rgb(42, 71, 114);
            width: 150px;
            height: 45px;
            align-self: flex-end;
            margin: 20px 0;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            margin-left: 10px;
        }
        .query-button-set input[type="button"]
        {
            color: white;
            background-color: rgb(42, 71, 114);
            width: 150px;
            height: 45px;
            align-self: flex-end;
            margin: 20px 0;
            border: none;
            border-radius: 2px;
            cursor: pointer;
        }
        .query-button-set input[type="submit"]:hover
        {
            background-color: rgb(62, 91, 134);
        }
        .query-form-order-seq{position: relative;}
        .order-seq-list
        {
            position: absolute;
            width: 600px;
            height: 367px;
            border: 1px solid black;
            left: 146px;
            top: 60px;
            background-color: white;
            display: flex;
            flex-flow: column nowrap;
            padding: 15px !important;
            border-bottom: 1px solid black !important;
            font-size: 12px;
            z-index: 2;
        }
        #order-seq-list{display: none;}
        .order-seq-list > span
        {
            align-self: flex-start;
        }
        .order-seq-list-header
        {
            width: 100%;
            display: flex;
            margin-top: 20px;
        }
        .order-seq-list-header > div
        {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 5px;
            background-color: #eee;
        }
        .order-seq-list-header > div:nth-of-type(1){flex: 2 1 0;}
        .order-seq-list-header > div:nth-of-type(2){flex: 2 1 0;}
        .order-seq-list-header > div:nth-of-type(3){flex: 4 1 0;}
        .order-seq-list-header > div:nth-of-type(4){flex: 1 1 0;}
        .order-seq-list-header > div:nth-of-type(5){flex: 2 1 0;}
        .order-seq-list-header > div:nth-of-type(6){flex: 1 1 0;}
        .order-seq-list-cols
        {
            width: 100%;
            display: flex;
        }
        .order-seq-list-cols > div
        {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 5px;
            border-bottom: 1px solid #ccc;
        }
        .order-seq-list-cols > div:nth-of-type(1){flex: 2 1 0;}        
        .order-seq-list-cols > div:nth-of-type(2){flex: 2 1 0;}        
        .order-seq-list-cols > div:nth-of-type(3){flex: 4 1 0;}        
        .order-seq-list-cols > div:nth-of-type(4){flex: 1 1 0;}        
        .order-seq-list-cols > div:nth-of-type(5){flex: 2 1 0;}        
        .order-seq-list-cols > div:nth-of-type(6){flex: 1 1 0;}        
		
        /* 체크박스 CSS */
        input[type="checkbox"]
        {
            display: none;
        }
        input[type="checkbox"] + label
        {
            position: relative;
            width: 17px;
            height: 17px;
            background-color: rgb(38, 85, 139);
            cursor: pointer;
            border-radius: 1px;
        }
        input[type="checkbox"] + label span
        {
            position: absolute;
            display: none;
            left: 5px;
            top: 1px;
            width: 4px;
            height: 10px;
            border-right: 2px solid white;
            border-bottom: 2px solid white;
            transform: rotateZ(40deg);
        }
        input[type="checkbox"] + label:hover
        {
            background-color: rgb(47, 105, 172);
        }
        input[type="checkbox"]:checked + label span
        {
            display: inline-block;
        }
    </style>
    
<section>
    <div class="query-form-wrapper">
        <div class="query-form-header">
            1:1 문의 수정
        </div>
        <form action="<%=request.getContextPath() %>/queryModifyEnd?querySeq=<%=qb.getQuerySeq() %>" method="post" class="query-form" name="queryFrm" enctype="multipart/form-data">
            <div class="query-form-title">
                <div>제목</div>
                <div><input type="text" name="queryTitle" id="" value="<%=qb.getQueryTitle()%>"></div>
            </div>
            <div class="query-form-order-seq">
                <div>주문번호</div>
                <div>
                    <input type="text" name="orderSeq" id="order-seq" value="<%=qb.getOrderSeq()%>" readonly>
                </div>
            </div>
            <div class="query-form-email">
                <div>이메일</div>
                <div>
                    <input type="text" name="memberEmail" id="member-email" readonly="readonly" value="<%=loginMember.getMemberEmail()%>">
                    <input type="checkbox" name="receiveEmail" id="receive-email" class="receive-email"><label for="receive-email"><span></span></label>답변을 이메일로 받겠습니다.
                </div>
            </div>
            <div class="query-form-content">
                <div>문의내용</div>
                <div><textarea name="queryContents"><%=qb.getQueryContents()%></textarea></div>
            </div>
            <div class="query-form-image-upload">
                <div>이미지</div>
                <div class="added-image-container">
                    <%if(imgList!=null){ 
                    	for(int i=0; i<imgList.size(); i++){%>
                    <div class="added-image-box">
                        <img src="<%=request.getContextPath() %>/upload/queryBoard/<%=imgList.get(i).getRenameFile() %>">
                    	<input type="hidden" name="oldFile" value="<%=imgList.get(i).getRenameFile()%>"/>
                    </div>
                    <%}} %>
                    <div class="image-upload-container">
                        <span>+</span><input type="file" name="upFile" id="originalFile" multiple>
                    </div>
                    
                </div>
            </div>
            <div class="query-button-set">
                <input id="cancel" type="button" value="취소">
                <input type="submit" value="수정">
            </div>
        </form>
    </div>
    </section>
<script>
	//주문 조회창 토글
	const showOrderSeqBtn = $('#show-orderlist');
	const orderSeqList = $('.order-seq-list');
	
	$(() => {
	    showOrderSeqBtn.on('click', (e) => {
	        if(orderSeqList.is(':animated')) return;
	        orderSeqList.fadeToggle(150);
	        
	        $('body').on('click', (e) => {
	            if(e.target == showOrderSeqBtn[0] || orderSeqList[0].contains(e.target)) return;
	            orderSeqList.fadeToggle(150).clearQueue();
	            $('body').off('click');
	        });
	    });
	});
	
	//주문번호 선택시 입력
	const orderSeqRadio = $('.order-seq-radio');
	const orderSeqInput = $('#order-seq');
	
	$(() => {
	    orderSeqRadio.on('click', (e) => {
	        const selectedOrderSeq = $(e.target).parent().siblings().first().text();
	        orderSeqInput.val(selectedOrderSeq);
	        orderSeqList.fadeToggle(150);
	        $('body').off('click');
	    });
	});
	
	
	const addedImageContainer = $('.added-image-container');
	const queryForm = $('.query-form');
	const fileImage = $('.added-image-box > img');
	$(function(){
		$("[name=upFile]").change(function(){
			
			$.each(queryFrm.upFile.files,function(index,item){
			
			console.log(item);
				
			var reader=new FileReader();
			reader.onload= function(e){
			    fileImage.attr('src', e.target.result);
			}
			reader.readAsDataURL(queryFrm.upFile.files[index]);//웹에서는 하드의 파일을 접근못하게 되어있어서 처리해주기위함 0은단일 index 넣어줘서 여러개처리
		});
		});
	});

</script>

<%@ include file="/views/common/footer.jsp" %>