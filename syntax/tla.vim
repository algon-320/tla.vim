" vim: ft=vim:fdm=marker

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" TLA+ Syntax {{{
syn keyword tlaStatement CASE OTHER IF THEN ELSE LET IN
syn keyword tlaBoolean TRUE FALSE BOOLEAN 
syn keyword tlaNormalOperator CHOOSE SUBSET UNION DOMAIN EXCEPT ENABLE[D] UNCHANGED

syn keyword tlaModule MODULE EXTEND[S] INSTANCE WITH LOCAL
syn keyword tlaConstant CONSTANT[S] VARIABLE[S] ASSUME

syn keyword tla2Keyword THEOREM ACTION HAVE PICK SUFFICES ASSUMPTION HIDE PROOF TAKE AXIOM LAMBDA PROPOSITION TEMPORAL BY LEMMA PROVE USE COROLLARY NEW QED WITNESS DEF OBVIOUS RECURSIVE DEFINE OMITTED STATE DEFS

syntax region tlaComment start="(\*" end="\*)" contains=pluscalRegionAlgorithm
syntax match tlaSlashComment /\\\*.*/

syntax region tlaString  start=/"/ skip=/\\"/ end=/"/
syntax keyword tlaString STRING

syntax match tlaNumber /-\?\d\+\.\d\+/
syntax match tlaSetConditional /\\E/
syntax match tlaSetConditional /\\A/
syntax match tlaBinaryOperator /\\X/
syntax match tlaBinaryOperator /\\in/
"syntax match tlaSetConditional /=>/


syntax match tlaBinaryOperator /\\\// 
syntax match tlaBinaryOperator /\/\\/ 
syntax match tlaEnd /=\{4,\}/ 

syn match tlaTemporalOperator /\\EE/ 
syn match tlaTemporalOperator /\\AA/ 
syn match tlaTemporalOperator /\[\]/
syn match tlaTemporalOperator /[^<]<>/
syn match tlaTemporalOperator /\~>/
syn match tlaFairnessOperator /[WS]F_\(<\)\{0,2\}\w\+\(>\)\{0,2\}/

syn region tlaSetRegion matchgroup=tlaStartSet start=/{/ matchgroup=tlaEndSet end=/}/ contains=tla.*
syn region tlaFunctionRegion matchgroup=tlaStartFunction start=/\[/ matchgroup=tlaEndFunction end=/\]/ contains=tla.*

" Defined to enable hiding it
syn region tlaTranslation start=/\\\* BEGIN TRANSLATION/ end=/\\\* END TRANSLATION/ fold

" }}}
" ^$ is good for whitespace delimiters?

" P-syntax Grammar: https://lamport.azurewebsites.net/tla/p-manual.pdf
" PlusCal Syntax {{{
syn keyword pluscalDeclaration contained variable[s]
syn keyword pluscalConditional contained with if elsif else then either while await goto
syn match   pluscalConditional contained /\<end if\>/
syn match   pluscalConditional contained /\<end either\>/
syn match   pluscalConditional contained /\<end while\>/

syn keyword pluscalOr contained or
hi def link pluscalOr pluscalConditional

syn keyword pluscalKeyword contained begin
syn keyword pluscalKeyword contained containedin=tla.*,@pluscalCluster self
"syn match pluscalProcess contained /\(fair \)\=process/
"syn keyword pluscalToDo   call goto return contained
syn keyword pluscalDebug contained assert print skip
syn match   pluscalLabel /\w\+:/
syn cluster pluscalCluster contains=pluscalDeclaration,pluscalConditional,pluscalKeyword,pluscalDebug,pluscalLabel,pluscalProcess

"BUG doesn't handle single process apps
syn region pluscalRegionAlgorithm matchgroup=pluscalMatchGroup start=/\(--algorithm\|--fair algorithm\)/ end=/\<end algorithm\>/ contains=tla.*,@pluscalCluster

syn region pluscalRegionDefine matchgroup=pluscalStartDefine start=/\<define\>/ matchgroup=pluscalEndDefine end=/\<end define;\?/ containedin=pluscalRegionAlgorithm contains=tla.*
hi def link pluscalStartDefine pluscalMatchGroup
hi def link pluscalEndDefine   pluscalMatchGroup

syn region pluscalRegionMacro matchgroup=pluscalStartMacro start=/\<macro\>/ matchgroup=pluscalEndMacro end=/\<end macro;\?/ containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
hi def link pluscalStartMacro pluscalMatchGroup
hi def link pluscalEndMacro   pluscalMatchGroup

syn region pluscalRegionProcedure matchgroup=pluscalStartProcedure start=/\<procedure\>/ matchgroup=pluscalEndProcedure end=/\<end procedure;\?/ containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
hi def link pluscalStartProcedure pluscalMatchGroup
hi def link pluscalEndProcedure   pluscalMatchGroup

syn region pluscalRegionProcess matchgroup=pluscalStartProcess start=/\<fair+\? process\>/ matchgroup=pluscalEndProcess end=/\<end process;\?/ containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
hi def link pluscalStartProcess pluscalMatchGroup
hi def link pluscalEndProcess   pluscalMatchGroup


" syn region pluscalRegionBegin matchgroup=pluscalStartBegin start=/\<begin\>/ matchgroup=pluscalEndBegin end=/\<end\>/ contained containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
" hi def link pluscalStartBegin pluscalMatchGroup
" hi def link pluscalEndBegin   pluscalMatchGroup

syn region pluscalRegionIf matchgroup=pluscalStartIf start=/\<then\>/ matchgroup=pluscalEndIf end=/\(\<elsif\>\|\<end if\>\)/ containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
hi def link pluscalStartIf pluscalConditional
hi def link pluscalEndIf   pluscalConditional

" TODO better nesting regions
syn region pluscalRegionDo matchgroup=pluscalStartDo start=/\<do\>/ matchgroup=pluscalEndDo end=/\<end\>/ containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
hi def link pluscalStartDo pluscalConditional
hi def link pluscalEndDo   pluscalConditional

syn region pluscalRegionEither matchgroup=pluscalStartEither start=/\<either\>/ matchgroup=pluscalEndEither end=/\<end either\>/ containedin=pluscalRegionAlgorithm contains=tla.*,@pluscalCluster
hi def link pluscalStartEither pluscalConditional
hi def link pluscalEndEither   pluscalConditional

" }}}

" Highlight {{{
hi def link tlaEnd                 Comment
hi def link tlaComment             Comment
hi def link tlaSlashComment        Comment
hi def link tlaFunc                Ignore
hi def link tlaBoolean             Boolean
hi def link tlaString              String
hi def link tlaNumber              Number
hi def link tlaNormalOperator      Special
hi def link tlaSetConditional      Repeat
hi def link tlaBinaryOperator      Operator
hi def link tlaTemporalOperator    Special
hi def link tlaStatement           Conditional
hi def link tlaModule              Include
hi def link tlaConstant            Define
hi def link tlaFairnessOperator    Operator
hi def link tla2Keyword            Keyword

hi def link pluscalKeyword         Special
hi def link pluscalMatchGroup      Special
hi def link pluscalProcess         Function
hi def link pluscalLabel           Label
hi def link pluscalDeclaration     Define
hi def link pluscalConditional     Conditional
hi def link pluscalDebug           Debug
" }}}
let b:current_syntax = "tla"
