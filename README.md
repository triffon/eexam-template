# eexam-latex

Главните файлове (с имена `eexam_<специалност>.tex`) се намират в главната директория. Условията на отделните задачи се включват от директорията `problems`. За компилация се използва LaTeX класът `eexam.cls`, който е включен като подмодул на това хранилище. За инициализиране и обновяване на подмодула могат да се използват следните команди:

``` shell
git submodule init
git submodule update
```

Компилиране на всички теми за всички специалности:

``` shell
export TEXINPUTS=eexam:$TEXINPUTS
for f in eexam*tex ; do pdflatex $f; done
```

или ако имате инсталиран `Latexmk`, просто

``` shell
latexmk
```

или

``` shell
make
```

Съвети:

Използвайте Visual Studio Code. Инсталирайте си разширението за LaTeX LaTeX Workshop.

Когато отворите главния файл, стартирайте Build (<alt или command>+shift+p / LaTeX Workshop: Build LaTeX Project). След това при всяко записване, файлът се прекомпилира сам.

Отворете си PDF файла вътре в VSCode в split pane view. При всяко прекомпилиране виждате промените веднага.

Като си отворите файл с конкретна задача и направите промени, като записвате, той сам се сеща да прекомплира PDF файла и веднага виждате промените.

Ако не използвате VSCode, но имате `Latexmk`, можете да го пуснете в "continuous preview mode" и да използвате любимия си редактор, като `Latexmk` ще следи за промени по всички входни файлове и автоматично ще ги прекомпилира:

``` shell
latexmk -pvc eexam_<специалност>.tex
```

Всяка от задачите може да се компилира самостоятелно, стига `eexam.cls` да се намира в пътя за търсене на LaTeX, например

``` shell
cd problems
export TEXINPUTS=../eexam:$TEXINPUTS
pdflatex problem_7*.tex
```

или с `Latexmk`:

``` shell
cd problems
latexmk problem_7*.tex
```

В кода на задачите могат да се добавят примерни решения и критерии за оценяване, ако са отделени в LaTeX по следния начин:
``` latex
\ifx\fmiprint\undefined
% тук е примерното решение
\fi
```

Примерните решения се извеждат при самостоятелно компилиране на задача и по подразбиране не се извеждат при компилиране на цялата тема. За компилиране на тема с включени решения може да се използва:

``` shell
latexmk -usepretex='\def\fmisolutions{}' -jobname=eexam_<специалност>_solutions eexam_<специалност>.tex
```

или за компилиране на всички теми с включени решения:

``` shell
make all_solutions
```

Има и функционалност за качване на компилираните файлове в Google Drive, като в метаданните на всеки пише от кое git подаване (commit) е компилиран.

Има папки за темите и задачите (за да можем да споделяме индивидуални задачи с авторите им). Уникалните идентификатори на PDF файловете в Google Drive и SHA256 хешовете на качените файлове се пазят във файла `gdrive.index`, при обновяване на задачите го подавайте и него в Git.

При промяна на задачите и темите след прекомпилиране могат да се качат ето така:

```shell
cd problems    # ако ще качвате задачите, а не темите
. ../eexam/gdrive_helpers.sh
gdrive_update out/*.pdf
```

или ако ползвате `make`:

```shell
cd problems    # ако ще качвате задачите, а не темите
make gdrive
```
