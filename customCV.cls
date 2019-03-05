\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{customCV}[04/03/2019 Lasse Krarup Custom CV]

\LoadClass{article}

% =============== DIMENSION ==================
% =============== DIMENSION ==================
% =============== DIMENSION ==================

\newlength{\@cv@lrmargin}
\setlength{\@cv@lrmargin}{3cm}

\newlength{\@cv@topmargin}
\setlength{\@cv@topmargin}{1.4cm}

\newlength{\hdrbotmargin}
\setlength{\hdrbotmargin}{0.25cm}

\newlength{\secvmargin}
\setlength{\secvmargin}{4pt}

\newlength{\@fa@sep}
\setlength{\@fa@sep}{0.2em}
\newcommand{\fasep}{%
    \hspace{\@fa@sep}
}

\newlength{\@ver@bar}
\setlength{\@ver@bar}{1em}
\newcommand{\verbar}{%
    \hspace{\@ver@bar} | \hspace{\@ver@bar}
}

% Adjust page
\RequirePackage[a4paper, hmargin=\@cv@lrmargin, top=\@cv@topmargin]{geometry}

\RequirePackage{calc}
\newlength{\leftcolumnwidth}
\newlength{\rightcolumnwidth}
\setlength{\leftcolumnwidth}{2.5cm}
\setlength{\rightcolumnwidth}{\textwidth-\leftcolumnwidth} % fit column based on left column width

% =============== OPTIONS ==============
% =============== OPTIONS ==============
% =============== OPTIONS ==============

\RequirePackage[hidelinks]{hyperref}
\RequirePackage{kvoptions-patch}
\RequirePackage{xkeyval}

\def\@authorname{Name McNamerson}
\def\@phonenumber{1234 5678}
\def\@address{Addresse, 12345 By}
\def\@mail{mail@gmail.com}

\DeclareOptionX{name}[Name McNamerson]{%
    \def\@authorname{#1}%
}

\def\@linkedin{}
\DeclareOptionX{linkedin}{%
    \def\@linkedin{\verbar\faLinkedinSquare}
}

\DeclareOptionX{linkedinlink}{%
    \def\@linkedin{\verbar\href{#1}{\faLinkedinSquare}}
}

\def\@github{}
\DeclareOptionX{github}[]{%
        \def\@github{\verbar\href{https://github.com/#1}{\faGithub \fasep #1}}
}

\DeclareOptionX{phone}{%
    \def\@phonenumber{\faMobilePhone\fasep #1}%
}

\DeclareOptionX{address}{%
    \def\@address{\faHome\fasep #1}%
}

\DeclareOptionX{mail}{%
        \def\@mail{\href{mailto:#1}{\faEnvelopeO\fasep #1}}%
}

\ProcessOptionsX

% Pass unknown options to the article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% ================ FONTS =======================
% ================ FONTS =======================
% ================ FONTS =======================

\RequirePackage{fontspec}

\RequirePackage{fontawesome}

\setmainfont{Montserrat}[%
    Path = Fonts/,
    Extension = .ttf,
    UprightFont = *-Regular,
    BoldFont = *-SemiBold,
    ItalicFont = *-Italic
]

\newfontfamily\titlefont{Dosis}[ 
  Path = Fonts/,
  Extension = .ttf,
  UprightFont = *-Light,
  BoldFont = *-SemiBold,
  LetterSpace = 16
]



% ============== CUSTOM COMMANDS ==============
% ============== CUSTOM COMMANDS ==============
% ============== CUSTOM COMMANDS ==============

%\RequirePackage{titlesec}

\RequirePackage{xcolor}

\renewcommand{\maketitle}{
    \begingroup
        \Huge\centering\titlefont CV\quad \textbf{\@authorname}\par%
        \vspace*{6pt}
        \normalfont\normalsize\@phonenumber\verbar\@address\par\vspace{2pt}%
        \@mail\@linkedin\@github\par%
        \vspace*{4pt}
        \rule{8cm}{0.1pt}\vspace*{\hdrbotmargin}\par%
    \endgroup
}


\RequirePackage{tikzpagenodes}

\newcommand{\makepicture}[1]{%
    \begin{tikzpicture}[remember picture,overlay,shift={(current page.north east)}]
    \node[anchor=north east, xshift=2mm, yshift=2mm]{\includegraphics[width=3.8cm]{#1}};
    \end{tikzpicture}
}

\newif\if@icon
\define@key{sec}{icon}{%
    \@icontrue
    \def\print@icon{\faicon{#1}\quad}%
}

\renewcommand{\section}[2][]{%
    \begingroup\vspace*{2\secvmargin}
    \Large
        \setkeys{sec}{#1}
        \if@icon
            \makebox[0pt][r]{\print@icon}
        \else
        \fi
        \hspace*{-9pt}
        \MakeLowercase{#2}\par\vspace{\secvmargin}
    \endgroup
}

\RequirePackage{longtable}
\newenvironment{cvtab}%
    {%
    \begingroup
    \def\arraystretch{2}% spacing between rows
        \begin{longtable}%
            {%
                @{}% Remove padding 
                    p{\leftcolumnwidth}%
                @{}%
                    p{\rightcolumnwidth}%
                @{}% Remove padding
            }
    }%
    {%
        \end{longtable}%
        \endgroup
    }

\newcommand{\cvpoint}[5]{
    #1-\newline #2 & \MakeUppercase{\bfseries#3} \textit{#4}\newline%
        #5
}