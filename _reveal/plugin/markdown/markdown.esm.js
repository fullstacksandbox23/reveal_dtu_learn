var e,t,n,r=(e=function(e){function t(){return{baseUrl:null,breaks:!1,gfm:!0,headerIds:!0,headerPrefix:"",highlight:null,langPrefix:"language-",mangle:!0,pedantic:!1,renderer:null,sanitize:!1,sanitizer:null,silent:!1,smartLists:!1,smartypants:!1,tokenizer:null,walkTokens:null,xhtml:!1}}e.exports={defaults:{baseUrl:null,breaks:!1,gfm:!0,headerIds:!0,headerPrefix:"",highlight:null,langPrefix:"language-",mangle:!0,pedantic:!1,renderer:null,sanitize:!1,sanitizer:null,silent:!1,smartLists:!1,smartypants:!1,tokenizer:null,walkTokens:null,xhtml:!1},getDefaults:t,changeDefaults:function(t){e.exports.defaults=t}}},e(n={path:t,exports:{},require:function(e,t){return function(){throw new Error("Dynamic requires are not currently supported by @rollup/plugin-commonjs")}(null==t&&n.path)}},n.exports),n.exports);const s=/[&<>"']/,i=/[&<>"']/g,l=/[<>"']|&(?!#?\w+;)/,a=/[<>"']|&(?!#?\w+;)/g,o={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"},c=e=>o[e];const p=/&(#(?:\d+)|(?:#x[0-9A-Fa-f]+)|(?:\w+));?/gi;function h(e){return e.replace(p,((e,t)=>"colon"===(t=t.toLowerCase())?":":"#"===t.charAt(0)?"x"===t.charAt(1)?String.fromCharCode(parseInt(t.substring(2),16)):String.fromCharCode(+t.substring(1)):""))}const u=/(^|[^\[])\^/g;const g=/[^\w:]/g,d=/^$|^[a-z][a-z0-9+.-]*:|^[?#]/i;const f={},k=/^[^:]+:\/*[^/]*$/,m=/^([^:]+:)[\s\S]*$/,b=/^([^:]+:\/*[^/]*)[\s\S]*$/;function x(e,t){f[" "+e]||(k.test(e)?f[" "+e]=e+"/":f[" "+e]=w(e,"/",!0));const n=-1===(e=f[" "+e]).indexOf(":");return"//"===t.substring(0,2)?n?t:e.replace(m,"$1")+t:"/"===t.charAt(0)?n?t:e.replace(b,"$1")+t:e+t}function w(e,t,n){const r=e.length;if(0===r)return"";let s=0;for(;s<r;){const i=e.charAt(r-s-1);if(i!==t||n){if(i===t||!n)break;s++}else s++}return e.substr(0,r-s)}var _={escape:function(e,t){if(t){if(s.test(e))return e.replace(i,c)}else if(l.test(e))return e.replace(a,c);return e},unescape:h,edit:function(e,t){e=e.source||e,t=t||"";const n={replace:(t,r)=>(r=(r=r.source||r).replace(u,"$1"),e=e.replace(t,r),n),getRegex:()=>new RegExp(e,t)};return n},cleanUrl:function(e,t,n){if(e){let e;try{e=decodeURIComponent(h(n)).replace(g,"").toLowerCase()}catch(e){return null}if(0===e.indexOf("javascript:")||0===e.indexOf("vbscript:")||0===e.indexOf("data:"))return null}t&&!d.test(n)&&(n=x(t,n));try{n=encodeURI(n).replace(/%25/g,"%")}catch(e){return null}return n},resolveUrl:x,noopTest:{exec:function(){}},merge:function(e){let t,n,r=1;for(;r<arguments.length;r++)for(n in t=arguments[r],t)Object.prototype.hasOwnProperty.call(t,n)&&(e[n]=t[n]);return e},splitCells:function(e,t){const n=e.replace(/\|/g,((e,t,n)=>{let r=!1,s=t;for(;--s>=0&&"\\"===n[s];)r=!r;return r?"|":" |"})).split(/ \|/);let r=0;if(n.length>t)n.splice(t);else for(;n.length<t;)n.push("");for(;r<n.length;r++)n[r]=n[r].trim().replace(/\\\|/g,"|");return n},rtrim:w,findClosingBracket:function(e,t){if(-1===e.indexOf(t[1]))return-1;const n=e.length;let r=0,s=0;for(;s<n;s++)if("\\"===e[s])s++;else if(e[s]===t[0])r++;else if(e[s]===t[1]&&(r--,r<0))return s;return-1},checkSanitizeDeprecation:function(e){e&&e.sanitize&&!e.silent&&console.warn("marked(): sanitize and sanitizer parameters are deprecated since version 0.7.0, should not be used and will be removed in the future. Read more here: https://marked.js.org/#/USING_ADVANCED.md#options")},repeatString:function(e,t){if(t<1)return"";let n="";for(;t>1;)1&t&&(n+=e),t>>=1,e+=e;return n+e}};const{defaults:y}=r,{rtrim:S,splitCells:z,escape:$,findClosingBracket:v}=_;function A(e,t,n){const r=t.href,s=t.title?$(t.title):null,i=e[1].replace(/\\([\[\]])/g,"$1");return"!"!==e[0].charAt(0)?{type:"link",raw:n,href:r,title:s,text:i}:{type:"image",raw:n,href:r,title:s,text:$(i)}}var R=class{constructor(e){this.options=e||y}space(e){const t=this.rules.block.newline.exec(e);if(t)return t[0].length>1?{type:"space",raw:t[0]}:{raw:"\n"}}code(e,t){const n=this.rules.block.code.exec(e);if(n){const e=t[t.length-1];if(e&&"paragraph"===e.type)return{raw:n[0],text:n[0].trimRight()};const r=n[0].replace(/^ {1,4}/gm,"");return{type:"code",raw:n[0],codeBlockStyle:"indented",text:this.options.pedantic?r:S(r,"\n")}}}fences(e){const t=this.rules.block.fences.exec(e);if(t){const e=t[0],n=function(e,t){const n=e.match(/^(\s+)(?:```)/);if(null===n)return t;const r=n[1];return t.split("\n").map((e=>{const t=e.match(/^\s+/);if(null===t)return e;const[n]=t;return n.length>=r.length?e.slice(r.length):e})).join("\n")}(e,t[3]||"");return{type:"code",raw:e,lang:t[2]?t[2].trim():t[2],text:n}}}heading(e){const t=this.rules.block.heading.exec(e);if(t){let e=t[2].trim();if(/#$/.test(e)){const t=S(e,"#");this.options.pedantic?e=t.trim():t&&!/ $/.test(t)||(e=t.trim())}return{type:"heading",raw:t[0],depth:t[1].length,text:e}}}nptable(e){const t=this.rules.block.nptable.exec(e);if(t){const e={type:"table",header:z(t[1].replace(/^ *| *\| *$/g,"")),align:t[2].replace(/^ *|\| *$/g,"").split(/ *\| */),cells:t[3]?t[3].replace(/\n$/,"").split("\n"):[],raw:t[0]};if(e.header.length===e.align.length){let t,n=e.align.length;for(t=0;t<n;t++)/^ *-+: *$/.test(e.align[t])?e.align[t]="right":/^ *:-+: *$/.test(e.align[t])?e.align[t]="center":/^ *:-+ *$/.test(e.align[t])?e.align[t]="left":e.align[t]=null;for(n=e.cells.length,t=0;t<n;t++)e.cells[t]=z(e.cells[t],e.header.length);return e}}}hr(e){const t=this.rules.block.hr.exec(e);if(t)return{type:"hr",raw:t[0]}}blockquote(e){const t=this.rules.block.blockquote.exec(e);if(t){const e=t[0].replace(/^ *> ?/gm,"");return{type:"blockquote",raw:t[0],text:e}}}list(e){const t=this.rules.block.list.exec(e);if(t){let e=t[0];const n=t[2],r=n.length>1,s={type:"list",raw:e,ordered:r,start:r?+n.slice(0,-1):"",loose:!1,items:[]},i=t[0].match(this.rules.block.item);let l,a,o,c,p,h,u,g,d=!1,f=i.length;o=this.rules.block.listItemStart.exec(i[0]);for(let t=0;t<f;t++){if(l=i[t],e=l,t!==f-1){if(c=this.rules.block.listItemStart.exec(i[t+1]),this.options.pedantic?c[1].length>o[1].length:c[1].length>o[0].length||c[1].length>3){i.splice(t,2,i[t]+"\n"+i[t+1]),t--,f--;continue}(!this.options.pedantic||this.options.smartLists?c[2][c[2].length-1]!==n[n.length-1]:r===(1===c[2].length))&&(p=i.slice(t+1).join("\n"),s.raw=s.raw.substring(0,s.raw.length-p.length),t=f-1),o=c}a=l.length,l=l.replace(/^ *([*+-]|\d+[.)]) ?/,""),~l.indexOf("\n ")&&(a-=l.length,l=this.options.pedantic?l.replace(/^ {1,4}/gm,""):l.replace(new RegExp("^ {1,"+a+"}","gm"),"")),h=d||/\n\n(?!\s*$)/.test(l),t!==f-1&&(d="\n"===l.charAt(l.length-1),h||(h=d)),h&&(s.loose=!0),this.options.gfm&&(u=/^\[[ xX]\] /.test(l),g=void 0,u&&(g=" "!==l[1],l=l.replace(/^\[[ xX]\] +/,""))),s.items.push({type:"list_item",raw:e,task:u,checked:g,loose:h,text:l})}return s}}html(e){const t=this.rules.block.html.exec(e);if(t)return{type:this.options.sanitize?"paragraph":"html",raw:t[0],pre:!this.options.sanitizer&&("pre"===t[1]||"script"===t[1]||"style"===t[1]),text:this.options.sanitize?this.options.sanitizer?this.options.sanitizer(t[0]):$(t[0]):t[0]}}def(e){const t=this.rules.block.def.exec(e);if(t){t[3]&&(t[3]=t[3].substring(1,t[3].length-1));return{tag:t[1].toLowerCase().replace(/\s+/g," "),raw:t[0],href:t[2],title:t[3]}}}table(e){const t=this.rules.block.table.exec(e);if(t){const e={type:"table",header:z(t[1].replace(/^ *| *\| *$/g,"")),align:t[2].replace(/^ *|\| *$/g,"").split(/ *\| */),cells:t[3]?t[3].replace(/\n$/,"").split("\n"):[]};if(e.header.length===e.align.length){e.raw=t[0];let n,r=e.align.length;for(n=0;n<r;n++)/^ *-+: *$/.test(e.align[n])?e.align[n]="right":/^ *:-+: *$/.test(e.align[n])?e.align[n]="center":/^ *:-+ *$/.test(e.align[n])?e.align[n]="left":e.align[n]=null;for(r=e.cells.length,n=0;n<r;n++)e.cells[n]=z(e.cells[n].replace(/^ *\| *| *\| *$/g,""),e.header.length);return e}}}lheading(e){const t=this.rules.block.lheading.exec(e);if(t)return{type:"heading",raw:t[0],depth:"="===t[2].charAt(0)?1:2,text:t[1]}}paragraph(e){const t=this.rules.block.paragraph.exec(e);if(t)return{type:"paragraph",raw:t[0],text:"\n"===t[1].charAt(t[1].length-1)?t[1].slice(0,-1):t[1]}}text(e,t){const n=this.rules.block.text.exec(e);if(n){const e=t[t.length-1];return e&&"text"===e.type?{raw:n[0],text:n[0]}:{type:"text",raw:n[0],text:n[0]}}}escape(e){const t=this.rules.inline.escape.exec(e);if(t)return{type:"escape",raw:t[0],text:$(t[1])}}tag(e,t,n){const r=this.rules.inline.tag.exec(e);if(r)return!t&&/^<a /i.test(r[0])?t=!0:t&&/^<\/a>/i.test(r[0])&&(t=!1),!n&&/^<(pre|code|kbd|script)(\s|>)/i.test(r[0])?n=!0:n&&/^<\/(pre|code|kbd|script)(\s|>)/i.test(r[0])&&(n=!1),{type:this.options.sanitize?"text":"html",raw:r[0],inLink:t,inRawBlock:n,text:this.options.sanitize?this.options.sanitizer?this.options.sanitizer(r[0]):$(r[0]):r[0]}}link(e){const t=this.rules.inline.link.exec(e);if(t){const e=t[2].trim();if(!this.options.pedantic&&/^</.test(e)){if(!/>$/.test(e))return;const t=S(e.slice(0,-1),"\\");if((e.length-t.length)%2==0)return}else{const e=v(t[2],"()");if(e>-1){const n=(0===t[0].indexOf("!")?5:4)+t[1].length+e;t[2]=t[2].substring(0,e),t[0]=t[0].substring(0,n).trim(),t[3]=""}}let n=t[2],r="";if(this.options.pedantic){const e=/^([^'"]*[^\s])\s+(['"])(.*)\2/.exec(n);e&&(n=e[1],r=e[3])}else r=t[3]?t[3].slice(1,-1):"";return n=n.trim(),/^</.test(n)&&(n=this.options.pedantic&&!/>$/.test(e)?n.slice(1):n.slice(1,-1)),A(t,{href:n?n.replace(this.rules.inline._escapes,"$1"):n,title:r?r.replace(this.rules.inline._escapes,"$1"):r},t[0])}}reflink(e,t){let n;if((n=this.rules.inline.reflink.exec(e))||(n=this.rules.inline.nolink.exec(e))){let e=(n[2]||n[1]).replace(/\s+/g," ");if(e=t[e.toLowerCase()],!e||!e.href){const e=n[0].charAt(0);return{type:"text",raw:e,text:e}}return A(n,e,n[0])}}strong(e,t,n=""){let r=this.rules.inline.strong.start.exec(e);if(r&&(!r[1]||r[1]&&(""===n||this.rules.inline.punctuation.exec(n)))){t=t.slice(-1*e.length);const n="**"===r[0]?this.rules.inline.strong.endAst:this.rules.inline.strong.endUnd;let s;for(n.lastIndex=0;null!=(r=n.exec(t));)if(s=this.rules.inline.strong.middle.exec(t.slice(0,r.index+3)),s)return{type:"strong",raw:e.slice(0,s[0].length),text:e.slice(2,s[0].length-2)}}}em(e,t,n=""){let r=this.rules.inline.em.start.exec(e);if(r&&(!r[1]||r[1]&&(""===n||this.rules.inline.punctuation.exec(n)))){t=t.slice(-1*e.length);const n="*"===r[0]?this.rules.inline.em.endAst:this.rules.inline.em.endUnd;let s;for(n.lastIndex=0;null!=(r=n.exec(t));)if(s=this.rules.inline.em.middle.exec(t.slice(0,r.index+2)),s)return{type:"em",raw:e.slice(0,s[0].length),text:e.slice(1,s[0].length-1)}}}codespan(e){const t=this.rules.inline.code.exec(e);if(t){let e=t[2].replace(/\n/g," ");const n=/[^ ]/.test(e),r=/^ /.test(e)&&/ $/.test(e);return n&&r&&(e=e.substring(1,e.length-1)),e=$(e,!0),{type:"codespan",raw:t[0],text:e}}}br(e){const t=this.rules.inline.br.exec(e);if(t)return{type:"br",raw:t[0]}}del(e){const t=this.rules.inline.del.exec(e);if(t)return{type:"del",raw:t[0],text:t[2]}}autolink(e,t){const n=this.rules.inline.autolink.exec(e);if(n){let e,r;return"@"===n[2]?(e=$(this.options.mangle?t(n[1]):n[1]),r="mailto:"+e):(e=$(n[1]),r=e),{type:"link",raw:n[0],text:e,href:r,tokens:[{type:"text",raw:e,text:e}]}}}url(e,t){let n;if(n=this.rules.inline.url.exec(e)){let e,r;if("@"===n[2])e=$(this.options.mangle?t(n[0]):n[0]),r="mailto:"+e;else{let t;do{t=n[0],n[0]=this.rules.inline._backpedal.exec(n[0])[0]}while(t!==n[0]);e=$(n[0]),r="www."===n[1]?"http://"+e:e}return{type:"link",raw:n[0],text:e,href:r,tokens:[{type:"text",raw:e,text:e}]}}}inlineText(e,t,n){const r=this.rules.inline.text.exec(e);if(r){let e;return e=t?this.options.sanitize?this.options.sanitizer?this.options.sanitizer(r[0]):$(r[0]):r[0]:$(this.options.smartypants?n(r[0]):r[0]),{type:"text",raw:r[0],text:e}}}};const{noopTest:T,edit:I,merge:E}=_,q={newline:/^(?: *(?:\n|$))+/,code:/^( {4}[^\n]+(?:\n(?: *(?:\n|$))*)?)+/,fences:/^ {0,3}(`{3,}(?=[^`\n]*\n)|~{3,})([^\n]*)\n(?:|([\s\S]*?)\n)(?: {0,3}\1[~`]* *(?:\n+|$)|$)/,hr:/^ {0,3}((?:- *){3,}|(?:_ *){3,}|(?:\* *){3,})(?:\n+|$)/,heading:/^ {0,3}(#{1,6})(?=\s|$)(.*)(?:\n+|$)/,blockquote:/^( {0,3}> ?(paragraph|[^\n]*)(?:\n|$))+/,list:/^( {0,3})(bull) [\s\S]+?(?:hr|def|\n{2,}(?! )(?! {0,3}bull )\n*|\s*$)/,html:"^ {0,3}(?:<(script|pre|style)[\\s>][\\s\\S]*?(?:</\\1>[^\\n]*\\n+|$)|comment[^\\n]*(\\n+|$)|<\\?[\\s\\S]*?(?:\\?>\\n*|$)|<![A-Z][\\s\\S]*?(?:>\\n*|$)|<!\\[CDATA\\[[\\s\\S]*?(?:\\]\\]>\\n*|$)|</?(tag)(?: +|\\n|/?>)[\\s\\S]*?(?:\\n{2,}|$)|<(?!script|pre|style)([a-z][\\w-]*)(?:attribute)*? */?>(?=[ \\t]*(?:\\n|$))[\\s\\S]*?(?:\\n{2,}|$)|</(?!script|pre|style)[a-z][\\w-]*\\s*>(?=[ \\t]*(?:\\n|$))[\\s\\S]*?(?:\\n{2,}|$))",def:/^ {0,3}\[(label)\]: *\n? *<?([^\s>]+)>?(?:(?: +\n? *| *\n *)(title))? *(?:\n+|$)/,nptable:T,table:T,lheading:/^([^\n]+)\n {0,3}(=+|-+) *(?:\n+|$)/,_paragraph:/^([^\n]+(?:\n(?!hr|heading|lheading|blockquote|fences|list|html| +\n)[^\n]+)*)/,text:/^[^\n]+/,_label:/(?!\s*\])(?:\\[\[\]]|[^\[\]])+/,_title:/(?:"(?:\\"?|[^"\\])*"|'[^'\n]*(?:\n[^'\n]+)*\n?'|\([^()]*\))/};q.def=I(q.def).replace("label",q._label).replace("title",q._title).getRegex(),q.bullet=/(?:[*+-]|\d{1,9}[.)])/,q.item=/^( *)(bull) ?[^\n]*(?:\n(?! *bull ?)[^\n]*)*/,q.item=I(q.item,"gm").replace(/bull/g,q.bullet).getRegex(),q.listItemStart=I(/^( *)(bull)/).replace("bull",q.bullet).getRegex(),q.list=I(q.list).replace(/bull/g,q.bullet).replace("hr","\\n+(?=\\1?(?:(?:- *){3,}|(?:_ *){3,}|(?:\\* *){3,})(?:\\n+|$))").replace("def","\\n+(?="+q.def.source+")").getRegex(),q._tag="address|article|aside|base|basefont|blockquote|body|caption|center|col|colgroup|dd|details|dialog|dir|div|dl|dt|fieldset|figcaption|figure|footer|form|frame|frameset|h[1-6]|head|header|hr|html|iframe|legend|li|link|main|menu|menuitem|meta|nav|noframes|ol|optgroup|option|p|param|section|source|summary|table|tbody|td|tfoot|th|thead|title|tr|track|ul",q._comment=/<!--(?!-?>)[\s\S]*?(?:-->|$)/,q.html=I(q.html,"i").replace("comment",q._comment).replace("tag",q._tag).replace("attribute",/ +[a-zA-Z:_][\w.:-]*(?: *= *"[^"\n]*"| *= *'[^'\n]*'| *= *[^\s"'=<>`]+)?/).getRegex(),q.paragraph=I(q._paragraph).replace("hr",q.hr).replace("heading"," {0,3}#{1,6} ").replace("|lheading","").replace("blockquote"," {0,3}>").replace("fences"," {0,3}(?:`{3,}(?=[^`\\n]*\\n)|~{3,})[^\\n]*\\n").replace("list"," {0,3}(?:[*+-]|1[.)]) ").replace("html","</?(?:tag)(?: +|\\n|/?>)|<(?:script|pre|style|!--)").replace("tag",q._tag).getRegex(),q.blockquote=I(q.blockquote).replace("paragraph",q.paragraph).getRegex(),q.normal=E({},q),q.gfm=E({},q.normal,{nptable:"^ *([^|\\n ].*\\|.*)\\n {0,3}([-:]+ *\\|[-| :]*)(?:\\n((?:(?!\\n|hr|heading|blockquote|code|fences|list|html).*(?:\\n|$))*)\\n*|$)",table:"^ *\\|(.+)\\n {0,3}\\|?( *[-:]+[-| :]*)(?:\\n *((?:(?!\\n|hr|heading|blockquote|code|fences|list|html).*(?:\\n|$))*)\\n*|$)"}),q.gfm.nptable=I(q.gfm.nptable).replace("hr",q.hr).replace("heading"," {0,3}#{1,6} ").replace("blockquote"," {0,3}>").replace("code"," {4}[^\\n]").replace("fences"," {0,3}(?:`{3,}(?=[^`\\n]*\\n)|~{3,})[^\\n]*\\n").replace("list"," {0,3}(?:[*+-]|1[.)]) ").replace("html","</?(?:tag)(?: +|\\n|/?>)|<(?:script|pre|style|!--)").replace("tag",q._tag).getRegex(),q.gfm.table=I(q.gfm.table).replace("hr",q.hr).replace("heading"," {0,3}#{1,6} ").replace("blockquote"," {0,3}>").replace("code"," {4}[^\\n]").replace("fences"," {0,3}(?:`{3,}(?=[^`\\n]*\\n)|~{3,})[^\\n]*\\n").replace("list"," {0,3}(?:[*+-]|1[.)]) ").replace("html","</?(?:tag)(?: +|\\n|/?>)|<(?:script|pre|style|!--)").replace("tag",q._tag).getRegex(),q.pedantic=E({},q.normal,{html:I("^ *(?:comment *(?:\\n|\\s*$)|<(tag)[\\s\\S]+?</\\1> *(?:\\n{2,}|\\s*$)|<tag(?:\"[^\"]*\"|'[^']*'|\\s[^'\"/>\\s]*)*?/?> *(?:\\n{2,}|\\s*$))").replace("comment",q._comment).replace(/tag/g,"(?!(?:a|em|strong|small|s|cite|q|dfn|abbr|data|time|code|var|samp|kbd|sub|sup|i|b|u|mark|ruby|rt|rp|bdi|bdo|span|br|wbr|ins|del|img)\\b)\\w+(?!:|[^\\w\\s@]*@)\\b").getRegex(),def:/^ *\[([^\]]+)\]: *<?([^\s>]+)>?(?: +(["(][^\n]+[")]))? *(?:\n+|$)/,heading:/^(#{1,6})(.*)(?:\n+|$)/,fences:T,paragraph:I(q.normal._paragraph).replace("hr",q.hr).replace("heading"," *#{1,6} *[^\n]").replace("lheading",q.lheading).replace("blockquote"," {0,3}>").replace("|fences","").replace("|list","").replace("|html","").getRegex()});const C={escape:/^\\([!"#$%&'()*+,\-./:;<=>?@\[\]\\^_`{|}~])/,autolink:/^<(scheme:[^\s\x00-\x1f<>]*|email)>/,url:T,tag:"^comment|^</[a-zA-Z][\\w:-]*\\s*>|^<[a-zA-Z][\\w-]*(?:attribute)*?\\s*/?>|^<\\?[\\s\\S]*?\\?>|^<![a-zA-Z]+\\s[\\s\\S]*?>|^<!\\[CDATA\\[[\\s\\S]*?\\]\\]>",link:/^!?\[(label)\]\(\s*(href)(?:\s+(title))?\s*\)/,reflink:/^!?\[(label)\]\[(?!\s*\])((?:\\[\[\]]?|[^\[\]\\])+)\]/,nolink:/^!?\[(?!\s*\])((?:\[[^\[\]]*\]|\\[\[\]]|[^\[\]])*)\](?:\[\])?/,reflinkSearch:"reflink|nolink(?!\\()",strong:{start:/^(?:(\*\*(?=[*punctuation]))|\*\*)(?![\s])|__/,middle:/^\*\*(?:(?:(?!overlapSkip)(?:[^*]|\\\*)|overlapSkip)|\*(?:(?!overlapSkip)(?:[^*]|\\\*)|overlapSkip)*?\*)+?\*\*$|^__(?![\s])((?:(?:(?!overlapSkip)(?:[^_]|\\_)|overlapSkip)|_(?:(?!overlapSkip)(?:[^_]|\\_)|overlapSkip)*?_)+?)__$/,endAst:/[^punctuation\s]\*\*(?!\*)|[punctuation]\*\*(?!\*)(?:(?=[punctuation_\s]|$))/,endUnd:/[^\s]__(?!_)(?:(?=[punctuation*\s])|$)/},em:{start:/^(?:(\*(?=[punctuation]))|\*)(?![*\s])|_/,middle:/^\*(?:(?:(?!overlapSkip)(?:[^*]|\\\*)|overlapSkip)|\*(?:(?!overlapSkip)(?:[^*]|\\\*)|overlapSkip)*?\*)+?\*$|^_(?![_\s])(?:(?:(?!overlapSkip)(?:[^_]|\\_)|overlapSkip)|_(?:(?!overlapSkip)(?:[^_]|\\_)|overlapSkip)*?_)+?_$/,endAst:/[^punctuation\s]\*(?!\*)|[punctuation]\*(?!\*)(?:(?=[punctuation_\s]|$))/,endUnd:/[^\s]_(?!_)(?:(?=[punctuation*\s])|$)/},code:/^(`+)([^`]|[^`][\s\S]*?[^`])\1(?!`)/,br:/^( {2,}|\\)\n(?!\s*$)/,del:T,text:/^(`+|[^`])(?:(?= {2,}\n)|[\s\S]*?(?:(?=[\\<!\[`*]|\b_|$)|[^ ](?= {2,}\n)))/,punctuation:/^([\s*punctuation])/,_punctuation:"!\"#$%&'()+\\-.,/:;<=>?@\\[\\]`^{|}~"};C.punctuation=I(C.punctuation).replace(/punctuation/g,C._punctuation).getRegex(),C._blockSkip="\\[[^\\]]*?\\]\\([^\\)]*?\\)|`[^`]*?`|<[^>]*?>",C._overlapSkip="__[^_]*?__|\\*\\*\\[^\\*\\]*?\\*\\*",C._comment=I(q._comment).replace("(?:--\x3e|$)","--\x3e").getRegex(),C.em.start=I(C.em.start).replace(/punctuation/g,C._punctuation).getRegex(),C.em.middle=I(C.em.middle).replace(/punctuation/g,C._punctuation).replace(/overlapSkip/g,C._overlapSkip).getRegex(),C.em.endAst=I(C.em.endAst,"g").replace(/punctuation/g,C._punctuation).getRegex(),C.em.endUnd=I(C.em.endUnd,"g").replace(/punctuation/g,C._punctuation).getRegex(),C.strong.start=I(C.strong.start).replace(/punctuation/g,C._punctuation).getRegex(),C.strong.middle=I(C.strong.middle).replace(/punctuation/g,C._punctuation).replace(/overlapSkip/g,C._overlapSkip).getRegex(),C.strong.endAst=I(C.strong.endAst,"g").replace(/punctuation/g,C._punctuation).getRegex(),C.strong.endUnd=I(C.strong.endUnd,"g").replace(/punctuation/g,C._punctuation).getRegex(),C.blockSkip=I(C._blockSkip,"g").getRegex(),C.overlapSkip=I(C._overlapSkip,"g").getRegex(),C._escapes=/\\([!"#$%&'()*+,\-./:;<=>?@\[\]\\^_`{|}~])/g,C._scheme=/[a-zA-Z][a-zA-Z0-9+.-]{1,31}/,C._email=/[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(@)[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+(?![-_])/,C.autolink=I(C.autolink).replace("scheme",C._scheme).replace("email",C._email).getRegex(),C._attribute=/\s+[a-zA-Z:_][\w.:-]*(?:\s*=\s*"[^"]*"|\s*=\s*'[^']*'|\s*=\s*[^\s"'=<>`]+)?/,C.tag=I(C.tag).replace("comment",C._comment).replace("attribute",C._attribute).getRegex(),C._label=/(?:\[(?:\\.|[^\[\]\\])*\]|\\.|`[^`]*`|[^\[\]\\`])*?/,C._href=/<(?:\\.|[^\n<>\\])+>|[^\s\x00-\x1f]*/,C._title=/"(?:\\"?|[^"\\])*"|'(?:\\'?|[^'\\])*'|\((?:\\\)?|[^)\\])*\)/,C.link=I(C.link).replace("label",C._label).replace("href",C._href).replace("title",C._title).getRegex(),C.reflink=I(C.reflink).replace("label",C._label).getRegex(),C.reflinkSearch=I(C.reflinkSearch,"g").replace("reflink",C.reflink).replace("nolink",C.nolink).getRegex(),C.normal=E({},C),C.pedantic=E({},C.normal,{strong:{start:/^__|\*\*/,middle:/^__(?=\S)([\s\S]*?\S)__(?!_)|^\*\*(?=\S)([\s\S]*?\S)\*\*(?!\*)/,endAst:/\*\*(?!\*)/g,endUnd:/__(?!_)/g},em:{start:/^_|\*/,middle:/^()\*(?=\S)([\s\S]*?\S)\*(?!\*)|^_(?=\S)([\s\S]*?\S)_(?!_)/,endAst:/\*(?!\*)/g,endUnd:/_(?!_)/g},link:I(/^!?\[(label)\]\((.*?)\)/).replace("label",C._label).getRegex(),reflink:I(/^!?\[(label)\]\s*\[([^\]]*)\]/).replace("label",C._label).getRegex()}),C.gfm=E({},C.normal,{escape:I(C.escape).replace("])","~|])").getRegex(),_extended_email:/[A-Za-z0-9._+-]+(@)[a-zA-Z0-9-_]+(?:\.[a-zA-Z0-9-_]*[a-zA-Z0-9])+(?![-_])/,url:/^((?:ftp|https?):\/\/|www\.)(?:[a-zA-Z0-9\-]+\.?)+[^\s<]*|^email/,_backpedal:/(?:[^?!.,:;*_~()&]+|\([^)]*\)|&(?![a-zA-Z0-9]+;$)|[?!.,:;*_~)]+(?!$))+/,del:/^(~~?)(?=[^\s~])([\s\S]*?[^\s~])\1(?=[^~]|$)/,text:/^([`~]+|[^`~])(?:(?= {2,}\n)|[\s\S]*?(?:(?=[\\<!\[`*~]|\b_|https?:\/\/|ftp:\/\/|www\.|$)|[^ ](?= {2,}\n)|[^a-zA-Z0-9.!#$%&'*+\/=?_`{\|}~-](?=[a-zA-Z0-9.!#$%&'*+\/=?_`{\|}~-]+@))|(?=[a-zA-Z0-9.!#$%&'*+\/=?_`{\|}~-]+@))/}),C.gfm.url=I(C.gfm.url,"i").replace("email",C.gfm._extended_email).getRegex(),C.breaks=E({},C.gfm,{br:I(C.br).replace("{2,}","*").getRegex(),text:I(C.gfm.text).replace("\\b_","\\b_| {2,}\\n").replace(/\{2,\}/g,"*").getRegex()});var O={block:q,inline:C};const{defaults:Z}=r,{block:N,inline:P}=O,{repeatString:U}=_;function L(e){return e.replace(/---/g,"—").replace(/--/g,"–").replace(/(^|[-\u2014/(\[{"\s])'/g,"$1‘").replace(/'/g,"’").replace(/(^|[-\u2014/(\[{\u2018\s])"/g,"$1“").replace(/"/g,"”").replace(/\.{3}/g,"…")}function D(e){let t,n,r="";const s=e.length;for(t=0;t<s;t++)n=e.charCodeAt(t),Math.random()>.5&&(n="x"+n.toString(16)),r+="&#"+n+";";return r}var M=class e{constructor(e){this.tokens=[],this.tokens.links=Object.create(null),this.options=e||Z,this.options.tokenizer=this.options.tokenizer||new R,this.tokenizer=this.options.tokenizer,this.tokenizer.options=this.options;const t={block:N.normal,inline:P.normal};this.options.pedantic?(t.block=N.pedantic,t.inline=P.pedantic):this.options.gfm&&(t.block=N.gfm,this.options.breaks?t.inline=P.breaks:t.inline=P.gfm),this.tokenizer.rules=t}static get rules(){return{block:N,inline:P}}static lex(t,n){return new e(n).lex(t)}static lexInline(t,n){return new e(n).inlineTokens(t)}lex(e){return e=e.replace(/\r\n|\r/g,"\n").replace(/\t/g,"    "),this.blockTokens(e,this.tokens,!0),this.inline(this.tokens),this.tokens}blockTokens(e,t=[],n=!0){let r,s,i,l;for(this.options.pedantic&&(e=e.replace(/^ +$/gm,""));e;)if(r=this.tokenizer.space(e))e=e.substring(r.raw.length),r.type&&t.push(r);else if(r=this.tokenizer.code(e,t))e=e.substring(r.raw.length),r.type?t.push(r):(l=t[t.length-1],l.raw+="\n"+r.raw,l.text+="\n"+r.text);else if(r=this.tokenizer.fences(e))e=e.substring(r.raw.length),t.push(r);else if(r=this.tokenizer.heading(e))e=e.substring(r.raw.length),t.push(r);else if(r=this.tokenizer.nptable(e))e=e.substring(r.raw.length),t.push(r);else if(r=this.tokenizer.hr(e))e=e.substring(r.raw.length),t.push(r);else if(r=this.tokenizer.blockquote(e))e=e.substring(r.raw.length),r.tokens=this.blockTokens(r.text,[],n),t.push(r);else if(r=this.tokenizer.list(e)){for(e=e.substring(r.raw.length),i=r.items.length,s=0;s<i;s++)r.items[s].tokens=this.blockTokens(r.items[s].text,[],!1);t.push(r)}else if(r=this.tokenizer.html(e))e=e.substring(r.raw.length),t.push(r);else if(n&&(r=this.tokenizer.def(e)))e=e.substring(r.raw.length),this.tokens.links[r.tag]||(this.tokens.links[r.tag]={href:r.href,title:r.title});else if(r=this.tokenizer.table(e))e=e.substring(r.raw.length),t.push(r);else if(r=this.tokenizer.lheading(e))e=e.substring(r.raw.length),t.push(r);else if(n&&(r=this.tokenizer.paragraph(e)))e=e.substring(r.raw.length),t.push(r);else if(r=this.tokenizer.text(e,t))e=e.substring(r.raw.length),r.type?t.push(r):(l=t[t.length-1],l.raw+="\n"+r.raw,l.text+="\n"+r.text);else if(e){const t="Infinite loop on byte: "+e.charCodeAt(0);if(this.options.silent){console.error(t);break}throw new Error(t)}return t}inline(e){let t,n,r,s,i,l;const a=e.length;for(t=0;t<a;t++)switch(l=e[t],l.type){case"paragraph":case"text":case"heading":l.tokens=[],this.inlineTokens(l.text,l.tokens);break;case"table":for(l.tokens={header:[],cells:[]},s=l.header.length,n=0;n<s;n++)l.tokens.header[n]=[],this.inlineTokens(l.header[n],l.tokens.header[n]);for(s=l.cells.length,n=0;n<s;n++)for(i=l.cells[n],l.tokens.cells[n]=[],r=0;r<i.length;r++)l.tokens.cells[n][r]=[],this.inlineTokens(i[r],l.tokens.cells[n][r]);break;case"blockquote":this.inline(l.tokens);break;case"list":for(s=l.items.length,n=0;n<s;n++)this.inline(l.items[n].tokens)}return e}inlineTokens(e,t=[],n=!1,r=!1){let s,i,l,a,o=e;if(this.tokens.links){const e=Object.keys(this.tokens.links);if(e.length>0)for(;null!=(i=this.tokenizer.rules.inline.reflinkSearch.exec(o));)e.includes(i[0].slice(i[0].lastIndexOf("[")+1,-1))&&(o=o.slice(0,i.index)+"["+U("a",i[0].length-2)+"]"+o.slice(this.tokenizer.rules.inline.reflinkSearch.lastIndex))}for(;null!=(i=this.tokenizer.rules.inline.blockSkip.exec(o));)o=o.slice(0,i.index)+"["+U("a",i[0].length-2)+"]"+o.slice(this.tokenizer.rules.inline.blockSkip.lastIndex);for(;e;)if(l||(a=""),l=!1,s=this.tokenizer.escape(e))e=e.substring(s.raw.length),t.push(s);else if(s=this.tokenizer.tag(e,n,r))e=e.substring(s.raw.length),n=s.inLink,r=s.inRawBlock,t.push(s);else if(s=this.tokenizer.link(e))e=e.substring(s.raw.length),"link"===s.type&&(s.tokens=this.inlineTokens(s.text,[],!0,r)),t.push(s);else if(s=this.tokenizer.reflink(e,this.tokens.links))e=e.substring(s.raw.length),"link"===s.type&&(s.tokens=this.inlineTokens(s.text,[],!0,r)),t.push(s);else if(s=this.tokenizer.strong(e,o,a))e=e.substring(s.raw.length),s.tokens=this.inlineTokens(s.text,[],n,r),t.push(s);else if(s=this.tokenizer.em(e,o,a))e=e.substring(s.raw.length),s.tokens=this.inlineTokens(s.text,[],n,r),t.push(s);else if(s=this.tokenizer.codespan(e))e=e.substring(s.raw.length),t.push(s);else if(s=this.tokenizer.br(e))e=e.substring(s.raw.length),t.push(s);else if(s=this.tokenizer.del(e))e=e.substring(s.raw.length),s.tokens=this.inlineTokens(s.text,[],n,r),t.push(s);else if(s=this.tokenizer.autolink(e,D))e=e.substring(s.raw.length),t.push(s);else if(n||!(s=this.tokenizer.url(e,D))){if(s=this.tokenizer.inlineText(e,r,L))e=e.substring(s.raw.length),a=s.raw.slice(-1),l=!0,t.push(s);else if(e){const t="Infinite loop on byte: "+e.charCodeAt(0);if(this.options.silent){console.error(t);break}throw new Error(t)}}else e=e.substring(s.raw.length),t.push(s);return t}};const{defaults:j}=r,{cleanUrl:H,escape:B}=_;var F=class{constructor(e){this.options=e||j}code(e,t,n){const r=(t||"").match(/\S*/)[0];if(this.options.highlight){const t=this.options.highlight(e,r);null!=t&&t!==e&&(n=!0,e=t)}return e=e.replace(/\n$/,"")+"\n",r?'<pre><code class="'+this.options.langPrefix+B(r,!0)+'">'+(n?e:B(e,!0))+"</code></pre>\n":"<pre><code>"+(n?e:B(e,!0))+"</code></pre>\n"}blockquote(e){return"<blockquote>\n"+e+"</blockquote>\n"}html(e){return e}heading(e,t,n,r){return this.options.headerIds?"<h"+t+' id="'+this.options.headerPrefix+r.slug(n)+'">'+e+"</h"+t+">\n":"<h"+t+">"+e+"</h"+t+">\n"}hr(){return this.options.xhtml?"<hr/>\n":"<hr>\n"}list(e,t,n){const r=t?"ol":"ul";return"<"+r+(t&&1!==n?' start="'+n+'"':"")+">\n"+e+"</"+r+">\n"}listitem(e){return"<li>"+e+"</li>\n"}checkbox(e){return"<input "+(e?'checked="" ':"")+'disabled="" type="checkbox"'+(this.options.xhtml?" /":"")+"> "}paragraph(e){return"<p>"+e+"</p>\n"}table(e,t){return t&&(t="<tbody>"+t+"</tbody>"),"<table>\n<thead>\n"+e+"</thead>\n"+t+"</table>\n"}tablerow(e){return"<tr>\n"+e+"</tr>\n"}tablecell(e,t){const n=t.header?"th":"td";return(t.align?"<"+n+' align="'+t.align+'">':"<"+n+">")+e+"</"+n+">\n"}strong(e){return"<strong>"+e+"</strong>"}em(e){return"<em>"+e+"</em>"}codespan(e){return"<code>"+e+"</code>"}br(){return this.options.xhtml?"<br/>":"<br>"}del(e){return"<del>"+e+"</del>"}link(e,t,n){if(null===(e=H(this.options.sanitize,this.options.baseUrl,e)))return n;let r='<a href="'+B(e)+'"';return t&&(r+=' title="'+t+'"'),r+=">"+n+"</a>",r}image(e,t,n){if(null===(e=H(this.options.sanitize,this.options.baseUrl,e)))return n;let r='<img src="'+e+'" alt="'+n+'"';return t&&(r+=' title="'+t+'"'),r+=this.options.xhtml?"/>":">",r}text(e){return e}},V=class{strong(e){return e}em(e){return e}codespan(e){return e}del(e){return e}html(e){return e}text(e){return e}link(e,t,n){return""+n}image(e,t,n){return""+n}br(){return""}},X=class{constructor(){this.seen={}}serialize(e){return e.toLowerCase().trim().replace(/<[!\/a-z].*?>/gi,"").replace(/[\u2000-\u206F\u2E00-\u2E7F\\'!"#$%&()*+,./:;<=>?@[\]^`{|}~]/g,"").replace(/\s/g,"-")}getNextSafeSlug(e,t){let n=e,r=0;if(this.seen.hasOwnProperty(n)){r=this.seen[e];do{r++,n=e+"-"+r}while(this.seen.hasOwnProperty(n))}return t||(this.seen[e]=r,this.seen[n]=0),n}slug(e,t={}){const n=this.serialize(e);return this.getNextSafeSlug(n,t.dryrun)}};const{defaults:G}=r,{unescape:J}=_;var K=class e{constructor(e){this.options=e||G,this.options.renderer=this.options.renderer||new F,this.renderer=this.options.renderer,this.renderer.options=this.options,this.textRenderer=new V,this.slugger=new X}static parse(t,n){return new e(n).parse(t)}static parseInline(t,n){return new e(n).parseInline(t)}parse(e,t=!0){let n,r,s,i,l,a,o,c,p,h,u,g,d,f,k,m,b,x,w="";const _=e.length;for(n=0;n<_;n++)switch(h=e[n],h.type){case"space":continue;case"hr":w+=this.renderer.hr();continue;case"heading":w+=this.renderer.heading(this.parseInline(h.tokens),h.depth,J(this.parseInline(h.tokens,this.textRenderer)),this.slugger);continue;case"code":w+=this.renderer.code(h.text,h.lang,h.escaped);continue;case"table":for(c="",o="",i=h.header.length,r=0;r<i;r++)o+=this.renderer.tablecell(this.parseInline(h.tokens.header[r]),{header:!0,align:h.align[r]});for(c+=this.renderer.tablerow(o),p="",i=h.cells.length,r=0;r<i;r++){for(a=h.tokens.cells[r],o="",l=a.length,s=0;s<l;s++)o+=this.renderer.tablecell(this.parseInline(a[s]),{header:!1,align:h.align[s]});p+=this.renderer.tablerow(o)}w+=this.renderer.table(c,p);continue;case"blockquote":p=this.parse(h.tokens),w+=this.renderer.blockquote(p);continue;case"list":for(u=h.ordered,g=h.start,d=h.loose,i=h.items.length,p="",r=0;r<i;r++)k=h.items[r],m=k.checked,b=k.task,f="",k.task&&(x=this.renderer.checkbox(m),d?k.tokens.length>0&&"text"===k.tokens[0].type?(k.tokens[0].text=x+" "+k.tokens[0].text,k.tokens[0].tokens&&k.tokens[0].tokens.length>0&&"text"===k.tokens[0].tokens[0].type&&(k.tokens[0].tokens[0].text=x+" "+k.tokens[0].tokens[0].text)):k.tokens.unshift({type:"text",text:x}):f+=x),f+=this.parse(k.tokens,d),p+=this.renderer.listitem(f,b,m);w+=this.renderer.list(p,u,g);continue;case"html":w+=this.renderer.html(h.text);continue;case"paragraph":w+=this.renderer.paragraph(this.parseInline(h.tokens));continue;case"text":for(p=h.tokens?this.parseInline(h.tokens):h.text;n+1<_&&"text"===e[n+1].type;)h=e[++n],p+="\n"+(h.tokens?this.parseInline(h.tokens):h.text);w+=t?this.renderer.paragraph(p):p;continue;default:{const e='Token with "'+h.type+'" type was not found.';if(this.options.silent)return void console.error(e);throw new Error(e)}}return w}parseInline(e,t){t=t||this.renderer;let n,r,s="";const i=e.length;for(n=0;n<i;n++)switch(r=e[n],r.type){case"escape":case"text":s+=t.text(r.text);break;case"html":s+=t.html(r.text);break;case"link":s+=t.link(r.href,r.title,this.parseInline(r.tokens,t));break;case"image":s+=t.image(r.href,r.title,r.text);break;case"strong":s+=t.strong(this.parseInline(r.tokens,t));break;case"em":s+=t.em(this.parseInline(r.tokens,t));break;case"codespan":s+=t.codespan(r.text);break;case"br":s+=t.br();break;case"del":s+=t.del(this.parseInline(r.tokens,t));break;default:{const e='Token with "'+r.type+'" type was not found.';if(this.options.silent)return void console.error(e);throw new Error(e)}}return s}};const{merge:Q,checkSanitizeDeprecation:W,escape:Y}=_,{getDefaults:ee,changeDefaults:te,defaults:ne}=r;function re(e,t,n){if(null==e)throw new Error("marked(): input parameter is undefined or null");if("string"!=typeof e)throw new Error("marked(): input parameter is of type "+Object.prototype.toString.call(e)+", string expected");if("function"==typeof t&&(n=t,t=null),t=Q({},re.defaults,t||{}),W(t),n){const r=t.highlight;let s;try{s=M.lex(e,t)}catch(e){return n(e)}const i=function(e){let i;if(!e)try{i=K.parse(s,t)}catch(t){e=t}return t.highlight=r,e?n(e):n(null,i)};if(!r||r.length<3)return i();if(delete t.highlight,!s.length)return i();let l=0;return re.walkTokens(s,(function(e){"code"===e.type&&(l++,setTimeout((()=>{r(e.text,e.lang,(function(t,n){if(t)return i(t);null!=n&&n!==e.text&&(e.text=n,e.escaped=!0),l--,0===l&&i()}))}),0))})),void(0===l&&i())}try{const n=M.lex(e,t);return t.walkTokens&&re.walkTokens(n,t.walkTokens),K.parse(n,t)}catch(e){if(e.message+="\nPlease report this to https://github.com/markedjs/marked.",t.silent)return"<p>An error occurred:</p><pre>"+Y(e.message+"",!0)+"</pre>";throw e}}re.options=re.setOptions=function(e){return Q(re.defaults,e),te(re.defaults),re},re.getDefaults=ee,re.defaults=ne,re.use=function(e){const t=Q({},e);if(e.renderer){const n=re.defaults.renderer||new F;for(const t in e.renderer){const r=n[t];n[t]=(...s)=>{let i=e.renderer[t].apply(n,s);return!1===i&&(i=r.apply(n,s)),i}}t.renderer=n}if(e.tokenizer){const n=re.defaults.tokenizer||new R;for(const t in e.tokenizer){const r=n[t];n[t]=(...s)=>{let i=e.tokenizer[t].apply(n,s);return!1===i&&(i=r.apply(n,s)),i}}t.tokenizer=n}if(e.walkTokens){const n=re.defaults.walkTokens;t.walkTokens=t=>{e.walkTokens(t),n&&n(t)}}re.setOptions(t)},re.walkTokens=function(e,t){for(const n of e)switch(t(n),n.type){case"table":for(const e of n.tokens.header)re.walkTokens(e,t);for(const e of n.tokens.cells)for(const n of e)re.walkTokens(n,t);break;case"list":re.walkTokens(n.items,t);break;default:n.tokens&&re.walkTokens(n.tokens,t)}},re.parseInline=function(e,t){if(null==e)throw new Error("marked.parseInline(): input parameter is undefined or null");if("string"!=typeof e)throw new Error("marked.parseInline(): input parameter is of type "+Object.prototype.toString.call(e)+", string expected");t=Q({},re.defaults,t||{}),W(t);try{const n=M.lexInline(e,t);return t.walkTokens&&re.walkTokens(n,t.walkTokens),K.parseInline(n,t)}catch(e){if(e.message+="\nPlease report this to https://github.com/markedjs/marked.",t.silent)return"<p>An error occurred:</p><pre>"+Y(e.message+"",!0)+"</pre>";throw e}},re.Parser=K,re.parser=K.parse,re.Renderer=F,re.TextRenderer=V,re.Lexer=M,re.lexer=M.lex,re.Tokenizer=R,re.Slugger=X,re.parse=re;var se=re;
/*!
 * The reveal.js markdown plugin. Handles parsing of
 * markdown inside of presentations as well as loading
 * of external markdown documents.
 */const ie="__SCRIPT_END__",le=/\[([\s\d,|-]*)\]/,ae={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"};export default()=>{let e;function t(e){var t=(e.querySelector("[data-template]")||e.querySelector("script")||e).textContent,n=(t=t.replace(new RegExp(ie,"g"),"<\/script>")).match(/^\n?(\s*)/)[1].length,r=t.match(/^\n?(\t*)/)[1].length;return r>0?t=t.replace(new RegExp("\\n?\\t{"+r+"}","g"),"\n"):n>1&&(t=t.replace(new RegExp("\\n? {"+n+"}","g"),"\n")),t}function n(e){for(var t=e.attributes,n=[],r=0,s=t.length;r<s;r++){var i=t[r].name,l=t[r].value;/data\-(markdown|separator|vertical|notes)/gi.test(i)||(l?n.push(i+'="'+l+'"'):n.push(i))}return n.join(" ")}function r(e){return(e=e||{}).separator=e.separator||"^\r?\n---\r?\n$",e.notesSeparator=e.notesSeparator||"notes?:",e.attributes=e.attributes||"",e}function s(e,t){t=r(t);var n=e.split(new RegExp(t.notesSeparator,"mgi"));return 2===n.length&&(e=n[0]+'<aside class="notes">'+se(n[1].trim())+"</aside>"),'<script type="text/template">'+(e=e.replace(/<\/script>/g,ie))+"<\/script>"}function i(e,t){t=r(t);for(var n,i,l,a=new RegExp(t.separator+(t.verticalSeparator?"|"+t.verticalSeparator:""),"mg"),o=new RegExp(t.separator),c=0,p=!0,h=[];n=a.exec(e);)!(i=o.test(n[0]))&&p&&h.push([]),l=e.substring(c,n.index),i&&p?h.push(l):h[h.length-1].push(l),c=a.lastIndex,p=i;(p?h:h[h.length-1]).push(e.substring(c));for(var u="",g=0,d=h.length;g<d;g++)h[g]instanceof Array?(u+="<section "+t.attributes+">",h[g].forEach((function(e){u+="<section data-markdown>"+s(e,t)+"</section>"})),u+="</section>"):u+="<section "+t.attributes+" data-markdown>"+s(h[g],t)+"</section>";return u}function l(e){return new Promise((function(r){var l=[];[].slice.call(e.querySelectorAll("[data-markdown]:not([data-markdown-parsed])")).forEach((function(e,r){e.getAttribute("data-markdown").length?l.push(function(e){return new Promise((function(t,n){var r=new XMLHttpRequest,s=e.getAttribute("data-markdown"),i=e.getAttribute("data-charset");null!=i&&""!=i&&r.overrideMimeType("text/html; charset="+i),r.onreadystatechange=function(e,r){4===r.readyState&&(r.status>=200&&r.status<300||0===r.status?t(r,s):n(r,s))}.bind(this,e,r),r.open("GET",s,!0);try{r.send()}catch(e){console.warn("Failed to get the Markdown file "+s+". Make sure that the presentation and the file are served by a HTTP server and the file can be found there. "+e),t(r,s)}}))}(e).then((function(t,r){e.outerHTML=i(t.responseText,{separator:e.getAttribute("data-separator"),verticalSeparator:e.getAttribute("data-separator-vertical"),notesSeparator:e.getAttribute("data-separator-notes"),attributes:n(e)})}),(function(t,n){e.outerHTML='<section data-state="alert">ERROR: The attempt to fetch '+n+" failed with HTTP status "+t.status+".Check your browser's JavaScript console for more details.<p>Remember that you need to serve the presentation HTML from a HTTP server.</p></section>"}))):e.getAttribute("data-separator")||e.getAttribute("data-separator-vertical")||e.getAttribute("data-separator-notes")?e.outerHTML=i(t(e),{separator:e.getAttribute("data-separator"),verticalSeparator:e.getAttribute("data-separator-vertical"),notesSeparator:e.getAttribute("data-separator-notes"),attributes:n(e)}):e.innerHTML=s(t(e))})),Promise.all(l).then(r)}))}function a(e,t,n){var r,s,i=new RegExp(n,"mg"),l=new RegExp('([^"= ]+?)="([^"]+?)"|(data-[^"= ]+?)(?=[" ])',"mg"),a=e.nodeValue;if(r=i.exec(a)){var o=r[1];for(a=a.substring(0,r.index)+a.substring(i.lastIndex),e.nodeValue=a;s=l.exec(o);)s[2]?t.setAttribute(s[1],s[2]):t.setAttribute(s[3],"");return!0}return!1}function o(e,t,n,r,s){if(null!=t&&null!=t.childNodes&&t.childNodes.length>0)for(var i=t,l=0;l<t.childNodes.length;l++){var c=t.childNodes[l];if(l>0)for(var p=l-1;p>=0;){var h=t.childNodes[p];if("function"==typeof h.setAttribute&&"BR"!=h.tagName){i=h;break}p-=1}var u=e;"section"==c.nodeName&&(u=c,i=c),"function"!=typeof c.setAttribute&&c.nodeType!=Node.COMMENT_NODE||o(u,c,i,r,s)}t.nodeType==Node.COMMENT_NODE&&0==a(t,n,r)&&a(t,e,s)}function c(){var n=e.getRevealElement().querySelectorAll("[data-markdown]:not([data-markdown-parsed])");return[].slice.call(n).forEach((function(e){e.setAttribute("data-markdown-parsed",!0);var n=e.querySelector("aside.notes"),r=t(e);e.innerHTML=se(r),o(e,e,null,e.getAttribute("data-element-attributes")||e.parentNode.getAttribute("data-element-attributes")||"\\.element\\s*?(.+?)$",e.getAttribute("data-attributes")||e.parentNode.getAttribute("data-attributes")||"\\.slide:\\s*?(\\S.+?)$"),n&&e.appendChild(n)})),Promise.resolve()}return{id:"markdown",init:function(t){e=t;let n=new se.Renderer;return n.code=(e,t)=>{let n="";return le.test(t)&&(n=t.match(le)[1].trim(),n=`data-line-numbers="${n}"`,t=t.replace(le,"").trim()),`<pre><code ${n} class="${t}">${e=e.replace(/([&<>'"])/g,(e=>ae[e]))}</code></pre>`},se.setOptions({renderer:n,...e.getConfig().markdown}),l(e.getRevealElement()).then(c)},processSlides:l,convertSlides:c,slidify:i,marked:se}};