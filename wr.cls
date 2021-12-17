\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wr}[2021/12/07 v0.9 Waardigheidsrichtlijn DZ Euros]

\newcommand{\lang}{en}
\newcommand{\boxbool}{1}

\DeclareOption{nl}{\renewcommand{\lang}{nl}}
\DeclareOption{en}{\renewcommand{\lang}{en}}
\DeclareOption{nobox}{\renewcommand{\boxbool}{0}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}


\ProcessOptions \relax

\LoadClass{article}

% class code
\RequirePackage[utf8]{inputenc}
\RequirePackage[]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage[numbib,nottoc]{tocbibind}

%%%%Add language to title, Rename Contents and Bibliography Sections %%%%

\RequirePackage{ifthen}
\RequirePackage{titling}

\ifthenelse{
    \equal{\lang}{nl}
}
{
    \posttitle{\par Nederlands \par\end{center}\vskip 0.5em}
    \renewcommand{\refname}{Boekenlijst}
    \renewcommand{\contentsname}{Inhoudsopgave}
}
{
    \posttitle{\par English \par\end{center}\vskip 0.5em}
    \renewcommand{\refname}{Book List}
}


%%% Include one of two language documents %%%

\newcommand{\includemultilang}[2]{
   \ifthenelse{
      \equal{\lang}{nl}
  }
  {\input{#1}}
  {\input{#2}}
}

%%% Add image to titlepage %%%%


\newcommand{\titleimage}[1]{
    \postdate{
        \par
        \LARGE \vskip 1.5em%
        \includegraphics[]{#1}
        \end{center}
    }
}


%%%% Define Style for Checkbox headers %%%%

\RequirePackage{titlesec}
\RequirePackage{needspace}
\RequirePackage{marginnote}

\reversemarginpar
\newcounter{checkboxlabel}
\renewcommand\LayoutCheckField[2]{#1#2}
\fboxsep=0pt
\ifthenelse{\equal{\boxbool}{1}}
{
    \titleformat{\subsubsection}
        [hang]
        {\needspace{50pt}\bfseries\large}
        {\thesubsubsection\quad}
        {0pt}
        {}
        [
        \marginnote{%
            \fbox{%
                \CheckBox[%
                    name=\arabic{checkboxlabel},%
                    width=20pt,height=20pt,bordercolor=black%
                ]{\null}\stepcounter{checkboxlabel}%
            }%
        }
        ]
}

%%%% Formats book references %%%%

\newcommand{\book}[1]{\par\hspace*{\fill}\textit{#1}}


%%%% Formats sailing license equivalents %%%%
 % {\marginnote{ or marginpar
\newcommand{\cwo}[1]{
    \marginnote[%
        \small\textit{#1}
    ]{}[20pt]
}

%%%% Formats important goals %%%%

\RequirePackage{wrapfig}
\RequirePackage{tcolorbox}
\RequirePackage{enumitem}

\newcommand{\eisen}[1]{
    \begin{wrapfigure}{hr}{0.5\textwidth}%
        \vspace{-1em}
        \itshape
        \begin{tcolorbox}[before skip= -3pt,
            after skip = -1em,
            boxsep = 0pt,
            sharp corners=all,
            colback = black!5,
            colframe = black]%
               \begin{itemize}[leftmargin=1em,label={%
                       \fbox{%
                            \CheckBox[%
                                name=\arabic{checkboxlabel},%
                                width=10pt,height=10pt,bordercolor=black%
                            ]{\null}\stepcounter{checkboxlabel}%
                        }%
                   }]%
                   \setlength\itemsep{-0.3em}%
                   #1%
               \end{itemize}
        \end{tcolorbox}
    \end{wrapfigure}}


%%%% Allows removing header from TOC %%%%
% used for examples in beginning
\newcommand{\nocontentsline}[3]{}
\newcommand{\tocless}[2]{\bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup}

%%% Other %%%

\bibliographystyle{apalike}
% \setcounter{tocdepth}{4}
% \settocfeature[toc][4]{entryhook}{\itshape}


%%% WIP: Checklist %%%

% \RequirePackage{tocloft}
% \newlistof{checklist}{chk}{Checklijst}
% \newcommand{\checklist}[1]{%
%     \refstepcounter{checklist}
%     \addcontentsline{chk}{checklist}{$\Box$ #1}
%     }


\endinput
