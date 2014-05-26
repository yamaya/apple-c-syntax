scriptencoding utf-8
" Vim syntax file
" Language:     Objective-C
" Maintainer:   Kazunobu Kuriyama <kazunobu.kuriyama@nifty.com>
" Last Change:  2013 Jun 13
" Remark:       Modern Objective-C Edition
" Modifier:     Masayuki Yamay <yamaya@cyberdom.co.jp>

""" Preparation for loading ObjC stuff
if exists("b:current_syntax")
  finish
endif
if &filetype != 'objcpp'
  syn clear
  runtime! syntax/c.vim
  runtime! syntax/c/*.vim
endif
let s:cpo_save = &cpo
set cpo&vim

syn region objcRepeatFor start="for\s*(" end=")" contains=objcRepeatForIn transparent
syn keyword objcRepeatForIn in
syn keyword objcStatement self super _cmd instancetype
syn keyword objcOperator typeof
syn keyword objcConstant nil Nil YES NO
syn keyword objcConstant __OBJC__ __OBJC2__ __clang__
syn keyword objcType id Class Protocol SEL IMP BOOL
syn match objcStorageClass "\<__\%(bridge\%(_\%(retained\|transfer\)\)\=\|autoreleasing\|unsafe_unretained\|strong\|weak\|unused\)\>" display
syn match objcAccess "@\%(public\|private\|protected\|optional\|required\|package\)\>" display
syn match objcStructure "@\%(interface\|class\|implementation\|protocol\|end\|compatibility_alias\)\>" display
syn match objcStatement "@\%(defs\|encode\|selector\|synthesize\|dynamic\|autoreleasepool\)\>" display
syn match objcStatement "@\%(try\|catch\|finally\|throw\|synchronized\)\>" display
syn match objcInclude "^\s*\%(%:\|#\)\s*import\>\s*["<]" contains=cIncluded display
syn match objcFormat "%@" contained display
syn region objcString	start=/@"/ skip=/\\\\\|\\"\|\\$/ excludenl end=/"/ end=/$/ contains=cSpecial,cFormat,objcFormat,@Spell display oneline

" プロパティ宣言構文 - nonatomicなどをハイライトするため
syn region objcProperty start="@property\s*(" end=")" transparent contains=objcPropertyAttributes display oneline
syn match objcPropertyKeyword "@property\>" display
syn match objcPropertyAttributes "\<\%(strong\|copy\|weak\|retain\|assign\|read\%(only\|write\)\|\%(non\)\=atomic\|[gs]etter\)\>" contained

" メッセージ送信構文 - [の直後は\Iか[か@とし空白は許可しない
syn region objcMessage start="\[\%([@\[]\|\I\)" end="\]" transparent
" ユーザ定義ラベルは引数名と衝突するので削除する
syn clear @cLabelGroup cUserCont cUserLabel

" オブジェクトリテラル、ボックス式、コンテナリテラル
syn match objcLiteralNumber "@\%(0x\x\+\%(u\=l\{0,2}\|ll\=u\)\|[-+]\?\%(\d\+\%(\.\d*\|L\?[UL]\)\?\|\.\d\+\)\|YES\|NO\|\%(FLT\|L\=DBL\)_\%(MIN\|MAX\)\)" display
syn region objcBoxedExpression matchgroup=objcBoxedExpressionBrackets start="@(" end=")" transparent
syn region objcContainerLiteralsArray matchgroup=objcContainerLiteralsBrackets start="@\[" end="\]" transparent display
syn region objcContainerLiteralsDictionary matchgroup=objcContainerLiteralsBrackets start="@{" end="}" transparent display

hi def link objcStatement									cStatement
hi def link objcOperator									cOperator
hi def link objcRepeatFor									objcStatement
hi def link objcRepeatForIn								objcRepeatFor
hi def link objcAccess										objcStatement
hi def link objcStructure									cStructure
hi def link objcPropertyKeyword						objcStatement
hi def link objcFunction									Function
hi def link objcInclude										cInclude
hi def link objcConstant									Constant
hi def link objcBoolean										Boolean
hi def link objcFormat										cSpecial
hi def link objcString										cString
hi def link objcType											cType
hi def link objcStorageClass							cStorageClass
hi def link objcClass											Tag
hi def link objcProtocol									objcClass
hi def link objcPropertyAttributes				objcStorageClass
hi def link objcLiteralNumber							Constant
hi def link objcBoxedExpressionBrackets		Directory
hi def link objcContainerLiteralsBrackets	Directory

let b:current_syntax = "objc"

let &cpo = s:cpo_save
unlet s:cpo_save
