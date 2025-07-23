import React from "react";
import { useGlobal } from "./GlobalContext";
import imgsrc from "../images/send.png"
import botimg from "../images/genu.png"
import chatopen from "../images/genu.png";
import { jwtDecode } from "jwt-decode";
import { useState } from "react";

const chatHeader = () => {
  const { close, setClose } = useGlobal();
  const [chatKey, setChatKey] = useState(0);
  const handleClose = () => {
      setClose(true);
      setChatKey(prev => prev + 1); // 컴포넌트를 새로 마운트
    };

  return (
    <div className="myheader" style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 10px'}}>
      💬 GENU 챗봇
      <span
        style={{ color: "white", cursor: "pointer", fontWeight: "bold", fontSize: "20px"}}
        onClick={handleClose}
      >
        x
      </span>
    </div>
  );
};

const chatButton = () => {
    return(
    <button><img src={imgsrc} alt="send button"/></button>
    );
}

const botImg = () => {
  return(
    <>
    <img src={botimg} className="botimg"/>
    </>
  );
}

const ChatOpen = () => {
  const { close, setClose } = useGlobal();
  const jwt = sessionStorage.getItem('jwt');
  let userInfo = null;
  if (jwt != null) {
    try {
      userInfo = jwtDecode(jwt);
      console.log("토큰있음");
    } catch (err) {
      console.error("JWT 디코딩 오류:", err);
    }
  } else {
    console.log("토큰없음");
  }
  return(
    <>
    {(userInfo?.role === "ADMIN" || userInfo?.role === "USER") ? (
      <div onClick={() => setClose(false)} style={{ cursor: 'pointer' }}>
        <img src={chatopen} style={{ width: '6%', height: '10%', position: 'fixed', right: '2%', bottom: '3%' }} />
        <span style={{ position: 'fixed', right: '1%', bottom: '13%' }}>AI 챗봇 NURUNG2입니다</span>
      </div>
    ) : <div style={{ cursor: 'not-allowed' }}>
        <img src={chatopen} style={{ width: '6%', height: '10%', position: 'fixed', right: '2%', bottom: '3%', opacity: 0.5 }} />
        <span style={{ position: 'fixed', right: '1%', bottom: '13%' }}>로그인 후 이용해 주세요</span>
      </div>}
    </>
  );
}

const loadSessionMessages = () => {
  const userMessages = JSON.parse(sessionStorage.getItem("user") || "[]");
  const botMessages = JSON.parse(sessionStorage.getItem("bot") || "[]");

  // 메시지를 시간순으로 interleave해서 하나의 배열로 합치기
  const allMessages = [];

  const maxLength = Math.max(userMessages.length, botMessages.length);
  for (let i = 0; i < maxLength; i++) {
    if (userMessages[i]) {
      allMessages.push({ type: "user", message: userMessages[i] });
    }
    if (botMessages[i]) {
      allMessages.push(botMessages[i]); // 이미 chatbotMessage 형태임
    }
  }

  return allMessages;
};

export { chatHeader, chatButton, botImg, ChatOpen, loadSessionMessages };