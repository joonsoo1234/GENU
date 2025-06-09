-- 기사 테이블 삭제
DROP TABLE news CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
DROP TABLE news;

CREATE TABLE news(
	news_no	NUMBER(10)	NOT NULL    PRIMARY KEY,
    member_no	NUMBER(10)	NOT NULL, --FK
	news_title	VARCHAR2(200)	NULL,
	news_content	CLOB	NULL,
	news_like	NUMBER(7)	NULL,
	news_cnt	NUMBER(7)	NULL,
    
	news_replycnt	NUMBER(7)	NULL,
	news_word	VARCHAR2(200)	NULL,
	news_rdate	DATE	NULL,
	file1	VARCHAR(100)	NULL,
	file1saved	VARCHAR(100)	NULL,
    
	thumb1	VARCHAR(100)	NULL,
	size1	NUMBER(10)	NULL,
	map	VARCHAR2(1000)	NULL,
	youtube	VARCHAR2(1000)	NULL,
	mp4	VARCHAR2(100)	NULL,
    
	visible	CHAR(1)	DEFAULT 'Y' NOT NULL,
	grade_no	NUMBER(7)	NOT NULL,
	emotion	NUMBER(1)	NOT NULL,
	summary	VARCHAR(1000)	NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE news is '기사';
COMMENT ON COLUMN news.news_no is '뉴스번호';
COMMENT ON COLUMN news.news_title is '제목';
COMMENT ON COLUMN news.news_content is '내용';
COMMENT ON COLUMN news.news_like is '추천';
COMMENT ON COLUMN news.news_cnt is '조회수';

COMMENT ON COLUMN news.news_replycnt is '댓글수';
COMMENT ON COLUMN news.news_word is '검색어';
COMMENT ON COLUMN news.news_rdate is '등록일';
COMMENT ON COLUMN news.file1 is '파일1';
COMMENT ON COLUMN news.file1saved is '저장된파일명1';

COMMENT ON COLUMN news.thumb1 is '프리뷰1';
COMMENT ON COLUMN news.size1 is '파일 크기1';
COMMENT ON COLUMN news.map is '지도';
COMMENT ON COLUMN news.youtube is '유튜브';
COMMENT ON COLUMN news.mp4 is 'mp4';

COMMENT ON COLUMN news.visible is '출력모드';
COMMENT ON COLUMN news.grade_no is '등급번호';
COMMENT ON COLUMN news.emotion is '호재악재';
COMMENT ON COLUMN news.emotion is '요약';

DROP SEQUENCE news_seq;
CREATE SEQUENCE news_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

-- 목록
INSERT INTO news(news_no, member_no, news_title, news_content, news_like, news_cnt,
                    news_replycnt, news_word, news_rdate, file1, file1saved,
                     thumb1, size1, grade_no, emotion, summary)
VALUES(news_seq.nextval, 1, '속보 ~', '기사내용', 0, 0, 0, '속보, 코인', sysdate, 'qq.jpg', 'qq_1.jpg', 'qq_t.jpg',
        1000, 1, 0, '코인의 대한 속보기사이다.');

COMMIT;
-- 여기까지 만
select * from news;     
            
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1, emotion, summary)
VALUES(contents_seq.nextval, 1, 2, '더글로리', '학교 폭력의 문제점을 드라마로 제작', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 0, '학폭의 결말');

INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1, emotion, summary)
VALUES(contents_seq.nextval, 1, 2, '폭삭 속았수다.', '나는 남들과 다르게 살고싶었는데 결국 자신만의 멋진 인생을 이룬 내용을 바탕으로 한 드라마', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000, 1, '평범한 인생인것 같지만 같은 인생은 어디에도 없다.');



-- 전체 목록
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
ORDER BY contentsno DESC;

-- 1번 cateno 만 출력
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=2
ORDER BY contentsno DESC;

-- 2번 cateno 만 출력
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 5번 cateno 만 출력
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=5
ORDER BY contentsno ASC;

commit;

-- 모든 레코드 삭제
DELETE FROM contents;
commit;

-- 삭제
DELETE FROM contents
WHERE contentsno = 25;
commit;

DELETE FROM contents
WHERE cateno=12 AND contentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- 검색, cateno별 검색 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
ORDER BY contentsno ASC;

-- 카테고리별 목록
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 1) 검색
-- ① cateno별 검색 목록
-- word 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=8 AND word LIKE '%부대찌게%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=8 AND (title LIKE '%부대찌게%' OR content LIKE '%부대찌게%' OR word LIKE '%부대찌게%')
ORDER BY contentsno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수, 집계 함수
SELECT COUNT(*)
FROM contents
WHERE cateno=8;

  COUNT(*)  <- 컬럼명
----------
         5
         
SELECT COUNT(*) as cnt -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM contents
WHERE cateno=8;

       CNT <- 컬럼명
----------
         5

-- cateno 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND word LIKE '%부대찌게%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND (title LIKE '%부대찌게%' OR content LIKE '%부대찌게%' OR word LIKE '%부대찌게%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이), 부분 문자열 추출
SELECT contentsno, SUBSTR(title, 1, 4) as title
FROM contents
WHERE cateno=8 AND (content LIKE '%부대%');

-- SQL은 대소문자를 구분하지 않으나 WHERE문에 명시하는 값은 대소문자를 구분하여 검색
SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%FOOD%');

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%food%'); 

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%food%'); -- 대소문자를 일치 시켜서 검색

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- 대소문자를 일치 시켜서 검색 ★

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT contentsno || '. ' || title || ' 태그: ' || word as title -- 컬럼의 결합, ||
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색


SELECT UPPER('한글') FROM dual; -- dual: 오라클에서 SQL 형식을 맞추기위한 시스템 테이블

-- ----------------------------------------------------------------------------------------------------
-- 검색 + 페이징 + 메인 이미지
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE cateno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary, rownum as r
FROM (
          SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
          FROM contents
          WHERE cateno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
          ORDER BY contentsno DESC
);

-- step 3, 1 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- 대소문자를 처리하는 페이징 쿼리
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
                     FROM contents
                     WHERE cateno=1 AND (UPPER(title) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('단풍') || '%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube, mp4, emotion, summary
FROM contents
WHERE contentsno = 1;

-- ----------------------------------------------------------------------------
-- 다음 지도, MAP, 먼저 레코드가 등록되어 있어야함.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP 등록/수정
UPDATE contents SET map='카페산 지도 스크립트' WHERE contentsno=1;

-- MAP 삭제
UPDATE contents SET map='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼저 레코드가 등록되어 있어야함.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube 등록/수정
UPDATE contents SET youtube='Youtube 스크립트' WHERE contentsno=1;

-- youtube 삭제
UPDATE contents SET youtube='' WHERE contentsno=1;

commit;

-- 패스워드 검사, id="password_check", 0 or 1
SELECT COUNT(*) as cnt 
FROM contents
WHERE contentsno=30 AND passwd='fS/kjO+fuEKk06Zl7VYMhg==';

       CNT
----------
         1

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE contents
SET title='기차를 타고', content='계획없이 여행 출발',  word='나,기차,생각' 
WHERE contentsno = 2;

-- ERROR, " 사용 에러
UPDATE contents
SET title='기차를 타고', content="계획없이 '여행' 출발",  word='나,기차,생각'
WHERE contentsno = 1;

-- ERROR, \' 에러
UPDATE contents
SET title='기차를 타고', content='계획없이 \'여행\' 출발',  word='나,기차,생각'
WHERE contentsno = 1;

-- SUCCESS, '' 한번 ' 출력됨.
UPDATE contents
SET title='기차를 타고', content='계획없이 ''여행'' 출발',  word='나,기차,생각'
WHERE contentsno = 1;

-- SUCCESS
UPDATE contents
SET title='기차를 타고', content='계획없이 "여행" 출발',  word='나,기차,생각'
WHERE contentsno = 1;

commit;

-- 파일 수정
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

-- 삭제
DELETE FROM contents
WHERE contentsno = 42;

commit;

DELETE FROM contents
WHERE contentsno >= 7;

commit;

-- cateno FK 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- memberno FK 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;

-- cateno FK 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM contents
WHERE cateno=1;

-- memberno FK 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM contents
WHERE memberno=1;

commit;

-- 다수의 카테고리에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       

-- ----------------------------------------------------------------------------------------------------
-- cate + contents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT c.name,
       t.contentsno, t.memberno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube
FROM cate c, contents t
WHERE c.cateno = t.cateno
ORDER BY t.contentsno DESC;

-- contents, member INNER JOIN
SELECT t.contentsno, t.memberno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM member a, contents t
WHERE a.memberno = t.memberno
ORDER BY t.contentsno DESC;

SELECT t.contentsno, t.memberno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM member a INNER JOIN contents t ON a.memberno = t.memberno
ORDER BY t.contentsno DESC;

-- ----------------------------------------------------------------------------------------------------
-- View + paging
-- ----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vcontents
AS
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
        file1, file1saved, thumb1, size1, map, youtube
FROM contents
ORDER BY contentsno DESC;
                     
-- 1 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcontents -- View
     WHERE cateno=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcontents -- View
     WHERE cateno=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 좋아요(recom) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, thumb1, r
FROM (
           SELECT contentsno, memberno, cateno, title, thumb1, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, thumb1
                     FROM contents
                     WHERE cateno=1
                     ORDER BY recom DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 평점(score) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY score DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 최신 상품 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY rdate DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 조회수 높은 상품기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY cnt DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 낮은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY price ASC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 높은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY price DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-----------------------------------------------------------
-- FK cateno 컬럼에 대응하는 필수 SQL
-----------------------------------------------------------
-- 특정 카테고리에 속한 레코드 갯수를 리턴
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;
  
-- 특정 카테고리에 속한 모든 레코드 삭제
DELETE FROM contents
WHERE cateno=1;

-----------------------------------------------------------
-- FK memberno 컬럼에 대응하는 필수 SQL
-----------------------------------------------------------
-- 특정 회원에 속한 레코드 갯수를 리턴
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;
  
-- 특정 회원에 속한 모든 레코드 삭제
DELETE FROM contents
WHERE memberno=1;

-----------------------------------------------------------
-- 추천 관련 SQL
-----------------------------------------------------------
-- 추천
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 1;

-- 비추천
UPDATE contents
SET recom = recom - 1
WHERE contentsno = 1;

1) 댓글수 증가
UPDATE contents
SET replycnt = replycnt + 1
WHERE contentsno = 3;

2) 댓글수 감소
UPDATE contents
SET replycnt = replycnt - 1
WHERE contentsno = 3;   

commit;


         
         
         

