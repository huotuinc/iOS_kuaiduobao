var $pluginID = "com.mob.sharesdk.Renren";eval(function(p,a,c,k,e,r){e=function(c){return(c<62?'':e(parseInt(c/62)))+((c=c%62)>35?String.fromCharCode(c+29):c.toString(36))};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'([89a-cefhk-mo-zA-Z]|[1-3]\\w)'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('c 2h="2M://2N.14.16/2O/login_success.html";c w={"1l":"app_id","1m":"app_key","1n":"secret_key","1I":"auth_type","1J":"covert_url"};h r(x){b.2P=x;b.s={"I":8,"J":8};b.1o=8;b.1p=8}r.q.x=h(){v b.2P};r.q.Q=h(){v"人人网"};r.q.L=h(){a(b.s["J"]!=8&&b.s["J"][w.1l]!=8){v b.s["J"][w.1l]}l a(b.s["I"]!=8&&b.s["I"][w.1l]!=8){v b.s["I"][w.1l]}v 8};r.q.W=h(){a(b.s["J"]!=8&&b.s["J"][w.1m]!=8){v b.s["J"][w.1m]}l a(b.s["I"]!=8&&b.s["I"][w.1m]!=8){v b.s["I"][w.1m]}v 8};r.q.12=h(){a(b.s["J"]!=8&&b.s["J"][w.1n]!=8){v b.s["J"][w.1n]}l a(b.s["I"]!=8&&b.s["I"][w.1n]!=8){v b.s["I"][w.1n]}v 8};r.q.M=h(){a(b.s["J"]!=8&&b.s["J"][w.1I]!=8){v b.s["J"][w.1I]}l a(b.s["I"]!=8&&b.s["I"][w.1I]!=8){v b.s["I"][w.1I]}v $9.e.M()};r.q.2i=h(){v"2Q-2R-"+$9.e.1x.1y+"-"+b.L()};r.q.2j=h(){a(b.s["J"]!=8&&b.s["J"][w.1J]!=8){v b.s["J"][w.1J]}l a(b.s["I"]!=8&&b.s["I"][w.1J]!=8){v b.s["I"][w.1J]}v $9.e.2j()};r.q.2S=h(1z){a(2T.1b==0){v b.s["I"]}l{b.s["I"]=b.2k(1z);b.2l();b.2m(b.L(),b.W(),b.12())}};r.q.2U=h(1z){a(2T.1b==0){v b.s["J"]}l{b.s["J"]=b.2k(1z);b.2l();b.2m(b.L(),b.W(),b.12())}};r.q.saveConfig=h(){c m=b;c 1q="2Q-2R";$9.K.2V("2W",1c,1q,h(f){a(f!=8){c 1K=f.1z;a(1K==8){1K={}}1K["plat_"+m.x()]=m.L();$9.K.2X("2W",1K,1c,1q,8)}})};r.q.isSupportAuth=h(){v 17};r.q.2Y=h(t,H){c o=8;a(b.2Z()){a(H==8){H={}}a(H["1A"]==8){H["1A"]=["publish_feed","status_update","photo_upload","read_user_photo","publish_share"]}c m=b;c M=b.M();a(M=="1B"||M=="sso"){$9.K.isMultitaskingSupported(h(f){a(f.N){m.30(h(N){a(N){m.31(h(1d,1C){a(1d){m.32(t,1C,H)}l a(M=="1B"){m.1r(t,H)}l{c o={"y":$9.e.B.UnsetURLScheme,"S":"分享平台［"+m.Q()+"］尚未配置33 34:"+m.1p+", 无法进行35授权!"};$9.D.O(t,$9.e.u.z,o)}})}l a(M=="1B"){m.1r(t,H)}l{c o={"y":$9.e.B.1L,"S":"分享平台［"+m.Q()+"］不支持["+M+"]授权方式!"};$9.D.O(t,$9.e.u.z,o)}})}l a(M=="1B"){m.1r(t,H)}l{c o={"y":$9.e.B.1L,"S":"分享平台［"+m.Q()+"］不支持["+M+"]授权方式!"};$9.D.O(t,$9.e.u.z,o)}})}l a(M=="web"){m.1r(t,H)}l{o={"y":$9.e.B.1L,"S":"分享平台［"+b.Q()+"］不支持["+M+"]授权方式!"};$9.D.O(t,$9.e.u.z,o)}}l{o={"y":$9.e.B.36,"S":"分享平台［"+b.Q()+"］应用信息无效!"};$9.D.O(t,$9.e.u.z,o)}};r.q.handleAuthCallback=h(t,1e){c o=8;c m=b;c 1Z=$9.P.parseUrl(1e);a(1Z!=8&&1Z.37!=8){c E=$9.P.parseUrlParameters(1Z.37);a(E!=8){c 38={"39":"3a "+$9.P.3b(E["3c"])};$9.K.3d($9.e.1x.1y,8,"1M://20.14.16/v2/p/login/3e","3f",8,38,h(f){a(f!=8){a(f["y"]!=8){$9.D.O(t,$9.e.u.z,f)}l a(f["2n"]!=8&&f["2n"]==3g){c F=$9.P.3h($9.P.3i(f["3j"]));a(F.o==8){E["X"]=F["F"]["id"];m.2o(t,E)}l{o={"y":$9.e.B.18,"1P":F};$9.D.O(t,$9.e.u.z,o)}}l{o={"y":$9.e.B.18,"1P":f};$9.D.O(t,$9.e.u.z,o)}}l{o={"y":$9.e.B.18};$9.D.O(t,$9.e.u.z,o)}})}l{o={"y":$9.e.B.3k,"S":"无效的授权回调:["+1e+"]"};$9.D.O(t,$9.e.u.z,o)}}l{o={"y":$9.e.B.3k,"S":"无效的授权回调:["+1e+"]"};$9.D.O(t,$9.e.u.z,o)}};r.q.handleSSOCallback=h(t,1e,sourceApplication,annotation){c m=b;a(1e.indexOf(b.1p+"://")==0){a(1e==b.1p+"://cancel"){$9.D.O(t,$9.e.u.3l,8);v 17}$9.K.ssdk_renrenHandleSSOCallback(b.L(),b.W(),b.12(),1e,h(f){3m(f.Y){21 $9.e.u.1s:{m.2o(t,f.N);19}21 $9.e.u.z:{c o={"y":$9.e.B.18,"1P":f.N};$9.D.O(t,$9.e.u.z,o);19}3n:$9.D.O(t,$9.e.u.3l,8);19}});v 17}v 1c};r.q.cancelAuthorize=h(){b.22(8,8)};r.q.addFriend=h(t,p,k){c o={"y":$9.e.B.1L,"S":"分享平台［"+b.Q()+"］不支持添加好友!"};a(k!=8){k($9.e.u.z,o)}};r.q.getFriends=h(cursor,1f,k){c o={"y":$9.e.B.1L,"S":"分享平台［"+b.Q()+"］不支持获取好友列表!"};a(k!=8){k($9.e.u.z,o)}};r.q.3o=h(t,T,k){c Z=8;c C=8;c 1g=8;c m=b;c 23=T!=8?T["@23"]:8;c 1D={"@23":23};c x=$9.e.1h(b.x(),T,"x");a(x==8){x=$9.e.1t.3p}a(x==$9.e.1t.3p){x=b.3q(T)}c E=8;3m(x){21 $9.e.1t.3r:{c U=$9.e.1h(b.x(),T,"U");a(2p.q.24.2q(U)===\'[2r 2s]\'){1g=U[0]}a(1g!=8){c 25=$9.e.1h(b.x(),T,"album_id");Z=$9.e.1h(b.x(),T,"Z");b.3s(1g,h(1Q){c 1R="application/octet-stream";a(/\\.jpe?g$/.1u(1Q)){1R="1g/jpeg"}l a(/\\.3t$/.1u(1Q)){1R="1g/3t"}l a(/\\.3u$/.1u(1Q)){1R="1g/3u"}c 1S={"path":1Q,"mime_type":1R};E={"1S":"@1S("+$9.P.26(1S)+")","2t":Z};a(25!=8){E["25"]=25}m.1E(h(p){m.2u([Z],h(f){E["2t"]=f.N[0];m.27("1M://20.14.16/v2/photo/upload","3v",E,8,h(Y,f){c G=f;a(Y==$9.e.u.1s){a(f!=8&&f["F"]!=8){G={};G["28"]=f["F"];G["3w"]=f["F"]["id"];G["Z"]=f["F"]["2t"];c U=f["F"]["U"];a(U!=8){1F(c i=0;i<U.1b;i++){c A=U[i];a(A["1f"]=="29"){G["U"]=[A["C"]]}}}}}a(k!=8){k(Y,G,p,1D)}})})})})}l{o={"y":$9.e.B.18,"S":"分享参数1g不能为空!"};a(k!=8){k($9.e.u.z,o,8,1D)}}19}21 $9.e.1t.3x:C=$9.e.1h(b.x(),T,"C");a(C!=8){Z=$9.e.1h(b.x(),T,"Z");E={"3y":Z,"C":C};b.1E(h(p){m.2u([Z,C],h(f){E["3y"]=f.N[0];E["C"]=f.N[1];m.27("1M://20.14.16/v2/3o/C/put","3v",E,8,h(Y,f){c G=f;a(Y==$9.e.u.1s){a(f!=8&&f["F"]!=8){G={};G["28"]=f["F"];G["3w"]=f["F"]["id"];G["Z"]=Z;G["urls"]=[f["F"]["C"]]}}a(k!=8){k(Y,G,p,1D)}})})})}l{o={"y":$9.e.B.18,"S":"分享参数C不能为空!"};a(k!=8){k($9.e.u.z,o,8,1D)}}19;3n:{c o={"y":$9.e.B.UnsupportContentType,"S":"不支持的分享类型["+x+"]"};a(k!=8){k($9.e.u.z,o,8,1D)}19}}};r.q.3z=h(2a,k){c m=b;b.1E(h(p){c E={};a(2a!=8){a(2a.X!=8){E["X"]=2a.X}}l a(p!=8&&p.10!=8&&p.10.X!=8){E["X"]=p.10.X}m.27("1M://20.14.16/v2/p/3e","3f",8,8,h(Y,f){c G=f;a(Y==$9.e.u.1s){G={"2v":$9.e.1x.1y};m.2w(G,f["F"]);a(G["X"]==p["X"]){G["10"]=p["10"]}}a(k!=8){k(Y,G)}})})};r.q.27=h(C,3A,E,1T,k){c o=8;c m=b;b.1E(h(p){a(p!=8){a(E==8){E={}}a(1T==8){1T={}}a(p.10!=8){1T["39"]="3a "+p.10.2x}$9.K.3d($9.e.1x.1y,8,C,3A,E,1T,h(f){a(f!=8){a(f["y"]!=8){a(k){k($9.e.u.z,f)}}l{c F=$9.P.3h($9.P.3i(f["3j"]));a(f["2n"]==3g){a(F["o"]==8){a(k){k($9.e.u.1s,F)}}l{c 2b=$9.e.B.18;a(F["o"]["2b"]=="invalid_authorization.INVALID-TOKEN"){2b=$9.e.B.3B}o={"y":2b,"1P":F};a(k){k($9.e.u.z,o)}}}l{o={"y":$9.e.B.18,"1P":F};a(k){k($9.e.u.z,o)}}}}l{o={"y":$9.e.B.18};a(k){k($9.e.u.z,o)}}})}l{o={"y":$9.e.B.3B,"S":"尚未授权["+m.Q()+"]用户"};a(k){k($9.e.u.z,o)}}})};r.q.createUserByRawData=h(R){c p={"2v":b.x()};b.2w(p,R);v $9.P.26(p)};r.q.3s=h(C,k){a(!/^(1S\\:\\/)?\\//.1u(C)){$9.K.downloadFile(C,h(f){a(f.N!=8){a(k!=8){k(f.N)}}l{a(k!=8){k(8)}}})}l{a(k!=8){k(C)}}};r.q.2u=h(2y,k){a(b.2j()){c m=b;b.1E(h(p){$9.e.convertUrl(m.x(),p,2y,k)})}l{a(k){k({"N":2y})}}};r.q.2w=h(p,R){a(p!=8&&R!=8){p["28"]=R;p["X"]=R["id"];p["nickname"]=R["Q"];c i=0;c A=8;c V=8;c 15=8;c 2c=R["V"];a(2c!=8){1F(i=0;i<2c.1b;i++){A=2c[i];a(A["1f"]=="29"){V=A;19}l a((V==8||V["1f"]!="29")&&A["1f"]=="3C"){V=A}l a((V==8||(V["1f"]!="29"&&V["1f"]!="3C"))&&A["1f"]=="HEAD"){V=A}l{V=A}}}a(V!=8){p["icon"]=V["C"]}a(R["2d"]!=8){c 1G=2;a(R["2d"]["3D"]=="MALE"){1G=0}l a(R["2d"]["3D"]=="FEMALE"){1G=1}p["1G"]=1G;c 1i=R["2d"]["1i"];15=/^(\\d+)-(\\d+)-(\\d+)$/;c 11=8;c 1U=8;a(15.1u(1i)){11=15.2z(1i);1U=2A 2B(11[1],11[2]-1,11[3],0,0,0);p["1i"]=1U.2C()/2D}l{15=/^(\\d+)后-(\\d+)-(\\d+)$/;a(15.1u(1i)){11=15.2z(1i);c 1H=2e(11[1]);a(1H==0){1H=3E}1U=2A 2B(1900+1H,11[2]-1,11[3],0,0,0);p["1i"]=1U.2C()/2D}}}l{p["1G"]=2}p["C"]="2M://www.14.16/"+R["id"];p["verify_type"]=R["star"];c 1v=8;c 2f=R["education"];a(2f!=8){1v=[];1F(i=0;i<2f.1b;i++){A={};c 13=2f[i];A["school"]=13["Q"];A["classes"]=13["department"];A["1H"]=2e(13["1H"]);c 1a=0;a(13["1w"]=="DOCTOR"){1a=7}l a(13["1w"]=="COLLEGE"){1a=5}l a(13["1w"]=="PRIMARY"){1a=1}l a(13["1w"]=="MASTER"){1a=6}l a(13["1w"]=="HIGHSCHOOL"){1a=4}l a(13["1w"]=="TECHNICAL"){1a=3}l a(13["1w"]=="JUNIOR"){1a=2}A["background"]=1a;1v.3F(A)}p["educations"]=1v}c 1V=R["1j"];a(1V!=8){1v=[];1F(i=0;i<1V.1b;i++){A={};c 1j=1V[i];A["company"]=1j["Q"];A["2E"]=1j["2E"]!=8?1j["2E"]["industryCategory"]:8;A["position"]=1j["3G"]!=8?1j["3G"]["jobCategory"]:8;c 1W=1j["1W"];a(1W!=8){15=/^(\\d+)-(\\d+)$/;a(15.1u(1W)){11=15.2z(1W);A["start_date"]=2e(11[1])*3E+2e(11[2])}}1v.3F(A)}p["1V"]=1v}}};r.q.1E=h(k){a(b.1o!=8){a(k){k(b.1o)}}l{c m=b;c 1q=b.2i();$9.K.2V("3H",1c,1q,h(f){m.1o=f!=8?f.1z:8;a(k){k(m.1o)}})}};r.q.2o=h(t,1X){c m=b;c 10={"X":1X["X"].24(),"2x":$9.P.3b(1X["3c"]),"expired":(2A 2B().2C()+1X["expires_in"]*2D),"28":1X,"x":$9.e.credentialType.OAuth2};c p={"2v":$9.e.1x.1y,"10":10};b.22(p,h(){m.3z(8,h(Y,f){a(Y==$9.e.u.1s){f["10"]=p["10"];p=f;m.22(p,8)}$9.D.O(t,$9.e.u.1s,p)})})};r.q.22=h(p,k){b.1o=p;c 1q=b.2i();$9.K.2X("3H",b.1o,1c,1q,h(f){a(k!=8){k()}})};r.q.31=h(k){c m=b;$9.K.3I(h(f){c 1C=8;c 2F="";c 1d=1c;c 2G=m.1p;a(f!=8&&f.2H!=8){1F(c i=0;i<f.2H.1b;i++){c 1Y=f.2H[i];a(1Y!=8&&1Y.2I!=8){1F(c j=0;j<1Y.2I.1b;j++){c 2J=1Y.2I[j];a(2J==2G){1d=17;1C=2J;19}}}a(1d){19}}}a(!1d){2F=2G}a(!1d){$9.D.3J("#3K:尚未配置["+m.Q()+"]33 34:"+2F+", 无法使用35授权, 将以Web方式进行授权。")}a(k!=8){k(1d,1C)}})};r.q.30=h(k){$9.K.2g("renrenapi://",h(f){a(f.N){a(k!=8){k(17)}}l{$9.K.2g("renrenios://",h(f){a(f.N){a(k!=8){k(17)}}l{$9.K.2g("renreniphone://",h(f){a(f.N){a(k!=8){k(17)}}l{$9.K.2g("14://",h(f){a(f.N){a(k!=8){k(17)}}l{a(k!=8){k(1c)}}})}})}})}})};r.q.2Z=h(){a(b.L()!=8&&b.W()!=8&&b.12()!=8){v 17}$9.D.3J("#3K:["+b.Q()+"]应用信息有误，不能进行相关操作。请检查本地代码中和服务端的["+b.Q()+"]平台应用配置是否有误! \\n本地配置:"+$9.P.26(b.2S())+"\\n服务器配置:"+$9.P.26(b.2U()));v 1c};r.q.1r=h(t,H){c 2K="1M://2N.14.16/2O/v2/wap/2Y?client_id="+b.W()+"&response_type=2x&redirect_uri="+$9.P.3L(2h)+"&display=mobile";a(H!=8&&H["1A"]!=8&&2p.q.24.2q(H["1A"])===\'[2r 2s]\'){2K+="&scope="+$9.P.3L(H["1A"].join(","))}$9.D.ssdk_openAuthUrl(t,2K,2h)};r.q.32=h(t,1C,H){c m=b;c M=m.M();$9.K.3M("16.9.3N.3O.14",h(f){a(f.N){$9.K.ssdk_renrenAuth(m.L(),m.W(),m.12(),H["1A"],h(f){a(f["y"]!=8){a(f["y"]==$9.e.B.NotYetInstallClient&&M=="1B"){m.1r(t,H)}l{$9.D.O(t,$9.e.u.z,f)}}})}l{a(M=="1B"){m.1r(t,H)}l{c o={"y":$9.e.B.36,"S":"分享平台［"+m.Q()+"］尚未导入RennSDK.framework!无法进行授权!"};$9.D.O(t,$9.e.u.z,o)}}})};r.q.2k=h(1k){c L=$9.P.2L(1k[w.1l]);c W=$9.P.2L(1k[w.1m]);c 12=$9.P.2L(1k[w.1n]);1k[w.1l]=L;1k[w.1m]=W;1k[w.1n]=12;v 1k};r.q.2l=h(){c m=b;b.1p=8;c L=b.L();a(L!=8){$9.K.3I(h(f){m.1p="rm"+L+f.CFBundleIdentifier})}};r.q.2m=h(L,W,12){a(L!=8&&W!=8&&12!=8){$9.K.3M("16.9.3N.3O.14",h(f){a(f.N){$9.D.ssdk_plugin_renren_setup(L,W,12)}})}};r.q.3q=h(T){c x=$9.e.1t.Text;c C=$9.e.1h(b.x(),T,"C");a(C!=8){x=$9.e.1t.3x}l{c U=$9.e.1h(b.x(),T,"U");a(2p.q.24.2q(U)===\'[2r 2s]\'){x=$9.e.1t.3r}}v x};$9.e.registerPlatformClass($9.e.1x.1y,r);',[],237,'||||||||null|mob|if|this|var||shareSDK|data||function|||callback|else|self||error|user|prototype|RenRen|_appInfo|sessionId|responseState|return|RenRenAppInfoKeys|type|error_code|Fail|item|errorCode|url|native|params|response|resultData|settings|local|server|ext|appId|authType|result|ssdk_authStateChanged|utils|name|rawData|error_message|parameters|images|avatar|appKey|uid|state|text|credential|res|secretKey|edu|renren|exp|com|true|APIRequestFail|break|degree|length|false|hasReady|callbackUrl|size|image|getShareParam|birthday|work|appInfo|AppID|AppKey|SecretKey|_currentUser|_authUrlScheme|domain|_webAuthorize|Success|contentType|test|list|educationBackground|platformType|Renren|value|scopes|both|urlScheme|userData|_getCurrentUser|for|gender|year|AuthType|ConvertUrl|curApps|UnsupportFeature|https|||user_data|imageUrl|mimeType|file|headers|date|works|time|credentialRawData|typeObj|urlInfo|api|case|_setCurrentUser|flags|toString|albumId|objectToJsonString|callApi|raw_data|LARGE|query|code|avatarList|basicInformation|parseInt|edus|canOpenURL|RenRenRedirectUri|cacheDomain|convertUrlEnabled|_checkAppInfoAvailable|_updateCallbackURLSchemes|_setupApp|status_code|_succeedAuthorize|Object|apply|object|Array|description|_convertUrl|platform_type|_updateUserInfo|token|contents|exec|new|Date|getTime|1000|industry|warningLog|callbackScheme|CFBundleURLTypes|CFBundleURLSchemes|schema|authUrl|trim|http|graph|oauth|_type|SSDK|Platform|localAppInfo|arguments|serverAppInfo|getCacheData|currentApp|setCacheData|authorize|_isAvailable|_isClientInstall|_checkUrlScheme|_ssoAuthorize|URL|Scheme|SSO|InvaildPlatform|fragment|header|Authorization|Bearer|urlDecode|access_token|ssdk_callHTTPApi|get|GET|200|jsonStringToObject|base64Decode|response_data|InvalidAuthCallback|Cancel|switch|default|share|Auto|_getShareType|Image|_getImagePath|png|gif|POST|cid|WebPage|comment|getUserInfo|method|UserUnauth|MAIN|sex|100|push|job|currentUser|getAppConfig|log|warning|urlEncode|isPluginRegisted|sharesdk|connector'.split('|'),0,{}))