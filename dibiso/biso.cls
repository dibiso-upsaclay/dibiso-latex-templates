\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dibiso/biso}[2025 BiSO template by Romain THOMAS]

\newcommand{\templatetype}{article}

\RequirePackage{import} % for file imports relative to path

\ifdefined\classdir
  % nothing to do, path already defined
\else
  % set the path to default
  \def\bisocolorsdir{dibiso}
\fi

\import{\classdir}{biso-colors}
\import{\classdir}{biso-dimensions}
\import{\classdir}{template-base}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% TITLE PAGE %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% date:
\newcommand{\titlepagedate}{\datefontsize\fontseries{b}\selectfont\titlecolor \@date \par}

\DeclareRobustCommand\titlebackgroundpicture[1]{\gdef\@titlebackgroundpicture{#1}}
\renewcommand*{\maketitle}{
  \begin{titlepage}
  %  \setcounter{page}{0}
    \begin{tikzpicture}[remember picture, overlay, every node/.style={inner sep=0,outer sep=0}]
      % lef t laser:
      % left part of the shading
      \shade[left color=titlepagegradientcolora, right color=titlepagegradientcolorb, shading angle=0](current page.north west) rectangle ([xshift=0.5\titlepagelaserwidth]current page.south west);
      % The yshift=0.2cm and yshift=-0.2cm are here to fix an alignement bug
      % right part of the shading with the fading on the right
      \shade[left color=titlepagegradientcolora, right color=titlepagegradientcolorb, shading angle=0, path fading=east]([xshift=0.49\titlepagelaserwidth, yshift=0.2cm]current page.north west) rectangle ([xshift=\titlepagelaserwidth, yshift=-0.2cm]current page.south west);
      % left part of the white shade
      \fill[color=white, path fading=west]([xshift=0.22\titlepagelaserwidth, yshift=0.2cm]current page.north west) rectangle ([xshift=0.301\titlepagelaserwidth, yshift=-0.2cm]current page.south west);
      % right part of the white shade
      \fill[color=white, path fading=east]([xshift=0.299\titlepagelaserwidth, yshift=0.2cm]current page.north west) rectangle ([xshift=0.38\titlepagelaserwidth, yshift=-0.2cm]current page.south west);
      % logo:
      \node [anchor=north west, xshift=\logoxpos, yshift=\logoypos] (logo) at (current page.south west) {\includegraphics[width=\logomaxw, height=\logomaxh, keepaspectratio]{\classdir /logo.eps}};
      % date:
      \node [anchor=south west, xshift=\datexshift, yshift=\dateyshift] (date) at (logo.north east){\titlepagedate};
      % title:
      \node [anchor=south west, text width=\titletextwidth, xshift=\titlexshift, yshift=\titleyshift] (title) at (date.north west) {\scalebox{4}{\parbox{0.25\titletextwidth}{\titlefont\titlefontsize\selectfont\titlecolor\@title}} \par};
      % subtitle:
      \node [text width=\subtitletextwidth] (subtitle) at (\subtitlexpos, \subtitleypos) {\subtitlefontsize\selectfont\titlecolor\raggedright \@subtitle \par};
    \end{tikzpicture}
  \end{titlepage}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% LAST PAGE %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand{\makelastpagecontactus}{
  \section*{Contactez-nous !}

  Pour échanger à propos de ce rapport ou tout autre questions liées à la science ouverte et vos publications, n'hésitez pas à contacter votre \textbf{référent·e laboratoire :}

  \ifx\@reporter\empty\else
    \thereporter
  \fi
  \ifx\@reporter\empty\else
    \ifx\@reporteremail\empty\else
      \\
    \fi
  \fi
  \ifx\@reporteremail\empty\else
    \href{mailto:\thereporteremail}{\thereporteremail}
  \fi
}


\newcommand{\makelastpagedatasources}{
  \section*{Source des données:}
  
  \begin{description}[leftmargin=0cm]
    \conditionalitem{\href{https://hal.science/}{HAL}:}{fig_jorunals_hal,fig_conferences,fig_doc_type,fig_open_access_works,fig_collab_map,fig_collab_map_europe,fig_collab_names,fig_private_collab,fig_eu_projects,fig_anr_projects}{tab_chapters,tab_journals}

    \conditionalitem{\href{https://openalex.org/}{OpenAlex}:}{fig_collab_map,fig_collab_map_europe}{}

    \conditionalitem{\href{https://scanr.enseignementsup-recherche.gouv.fr/}{scanR}:}{fig_private_collab}{}

    \conditionalitem{\href{https://barometredelascienceouverte.esr.gouv.fr/}{Baromètre français de la Science Ouverte}:}{}{tab_journals}
    
    % Add fallback item if no items were added
    \ifnum\value{descriptionitems}=0
      \item[No data sources]
    \fi
  \end{description}

  \vspace{-1ex}
  Données téléchargées le : \datafetchdate
}


\newcommand{\makelastpagecode}{
  \section*{Code:}

  \begin{description}[leftmargin=0cm]
    \item[Analyses et visualisations:] \url{https://github.com/dibiso-upsaclay/dibisoplot}
    \item[Modèle \LaTeX:] \url{https://github.com/dibiso-upsaclay/dibiso-latex-templates}
    \item[Génération du rapport:] \url{https://github.com/dibiso-upsaclay/dibisoreporting}
    \item[Application web:] \url{https://github.com/dibiso-upsaclay/dibiso-reporting-webapp}
    \item[API app web:] \url{https://github.com/dibiso-upsaclay/dibiso-reporting-api}
  \end{description}
}


\newcommand{\makelastpageauthors}{
  \vspace{10mm}

  Rédaction : \thereporter \\
  Conception : Henri Bretel, Delphine Le Piolet, Laili Rahimie, Romain Thomas \\
  Programmation : Romain Thomas
}



\newcommand{\makelastpagefooter}{
  \vfill
  
  \raggedright
  {\Large\titlefont\bfseries L'équipe Science Ouverte}
  \begin{tikzpicture}[every node/.style={inner sep=0,outer sep=0}]
    \node[shading=axis, rounded rectangle, left color=titlepagegradientcolora, right color=titlepagegradientcolorb, shading angle=90, minimum width=\textwidth, minimum height=\logorulewidth] {};
  \end{tikzpicture}
  
  \begin{minipage}{8cm}
    \small
    \medskip
    
    \href{mailto:science.ouverte@universite-paris-saclay.fr}{science.ouverte@universite-paris-saclay.fr}
    
    \medskip
    
    \url{https://www.universite-paris-saclay.fr/recherche/science-ouverte}
  \end{minipage}
  \hfill
  \begin{minipage}{6cm}
    \small
    % https://simpleicons.org/
    \includegraphics[height=\the\baselineskip, width=\the\baselineskip, keepaspectratio]{\classdir /icons/bluesky.eps} ~ \href{https://bsky.app/profile/so-upsaclay.bsky.social}{@so-upsaclay.bsky.social}
    
    \medskip
    
    \includegraphics[height=\the\baselineskip, width=\the\baselineskip, keepaspectratio]{\classdir /icons/mastodon.eps} ~ \href{https://social.sciences.re/@SO_UPSaclay}{social.sciences.re/@SO\_UPSaclay}
  \end{minipage}
  
  \vspace{5mm}
  
  \includegraphics[width=\linewidth]{\classdir /frise_upsaclay.eps}
  
  \vspace{5mm}
  
  \newcommand{\licenceslogo}{
    \href{https://creativecommons.org/licenses/by/4.0/}{\includegraphics[height=\the\dimexpr 2\baselineskip \relax]{\classdir /icons/by.eps}}
    \hspace{3mm}
    \href{https://www.etalab.gouv.fr/licence-ouverte-open-licence/}{\includegraphics[height=\the\dimexpr 2\baselineskip \relax]{\classdir /icons/etalab_licence.png}}
  }
  
  \begin{minipage}[c][\the\dimexpr 2\baselineskip \relax][c]{.47\linewidth}
    \begin{flushleft}
      \small Direction des Bibliothèques, de l'Information et de la Science Ouverte (DiBISO)
    \end{flushleft}
  \end{minipage}
  \hfill
  \begin{minipage}[c][\the\dimexpr 2\baselineskip \relax][c]{\widthof{\licenceslogo}}
    \licenceslogo
  \end{minipage}
  
  \vspace{-1cm}
}


\newcommand{\makelastpagereport}{
  \pagebreak
  
  \thispagestyle{empty}
  
  \makelastpagecontactus
  
  \makelastpagedatasources
  
  \makelastpagecode
  
  \makelastpageauthors
  
  \makelastpagefooter
}


