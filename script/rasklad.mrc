alias F12 {
  if (%text == rus) {
    editbox -a $replacecs($editbox($active),.,/,á,$chr(44),é,q,ö,w,ó,e,ê,r,å,t,í,y,ã,u,ø,i,ù,o,ç,p,õ,[,ú,],ô,a,û,s,â,d,à,f,ï,g,ð,h,î,j,ë,k,ä,l,æ,;,ý,',ÿ,z,÷,x,ñ,c,ì,v,è,b,ò,n,ü,m,þ,.,É,Q,Ö,W,Ó,E,Ê,R,Å,T,Í,Y,Ã,U,Ø,I,Ù,O,Ç,P,Ô,A,Û,S,Â,D,À,F,Ï,G,Ð,H,Î,J,Ë,K,Ä,L,Æ,:,Ý,",ß,Z,×,X,Ñ,C,Ì,V,È,B,Ò,N,Ü,M,Á,<,Þ,>,?,&,:,^,¸,`,;,$,@,",#,¹) | .dll dll/raskladka.dll ras_eng 
    .set %text eng | halt
  }

  if (%text == eng) {
    editbox -a $replacecs($editbox($active),.,þ,$chr(44),á,q,é,w,ö,e,ó,r,ê,t,å,y,í,u,ã,i,ø,o,ù,p,ç,[,õ,],ú,a,ô,s,û,d,â,f,à,g,ï,h,ð,j,î,k,ë,l,ä,;,æ,',ý,z,ÿ,x,÷,c,ñ,v,ì,b,è,n,ò,m,ü,.,þ,Q,É,W,Ö,E,Ó,R,Ê,T,Å,Y,Í,U,Ã,I,Ø,O,Ù,P,Ç,[,Õ,A,Ô,S,Û,D,Â,F,À,G,Ï,H,Ð,J,Î,K,Ë,L,Ä,:,Æ,",Ý,Z,ß,X,×,C,Ñ,V,Ì,B,È,N,Ò,<,Á,>,Þ,&,?,^,:,/,.,`,¸,$,;,",@,¹,#) | .dll dll/raskladka.dll ras_rus
    .set %text rus | halt
  }
}
