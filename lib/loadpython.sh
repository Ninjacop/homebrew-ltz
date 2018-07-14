#!/bin/bash

source $HOME/.ltz/lib/loaddocs.sh

function python-folders ()
{
    cd $HOME 
    if [ ! -d $Name ]
    then 
        mkdir $Name
        cd $Name
        mkdir tests
        mkdir sample
        mkdir docs
        python-gitignore
        changelog
        readme
        python-license
        python-manifest
        python-make
        python-requirements
        python-setup
        cd docs  
        intro
        sphinx-make
        python-bat
        cd ..
        cd sample
        python-init-sample
        python-core
        python-helpers
        cd ..
        cd tests
        python-init-tests
        python-context
        python-test-advanced
        python-test-basic
    else 
        echo "ERROR: Project folder \"$Name\" already exists. Delete the existing folder or make a new Project under a different name"
    fi
}

function python-gitignore ()
{
    echo "# Byte-compiled / optimized / DLL files
    __pycache__/
    *.py[cod]
    *\$py.class

    # C extensions
    *.so

    # Distribution / packaging
    .Python
    build/
    develop-eggs/
    dist/
    downloads/
    eggs/
    .eggs/
    lib/
    lib64/
    parts/
    sdist/
    var/
    wheels/
    *.egg-info/
    .installed.cfg
    *.egg
    MANIFEST

    # PyInstaller
    #  Usually these files are written by a python script from a template
    #  before PyInstaller builds the exe, so as to inject date/other infos into it.
    *.manifest
    *.spec

    # Installer logs
    pip-log.txt
    pip-delete-this-directory.txt

    # Unit test / coverage reports
    htmlcov/
    .tox/
    .coverage
    .coverage.*
    .cache
    nosetests.xml
    coverage.xml
    *.cover
    .hypothesis/
    .pytest_cache/

    # Translations
    *.mo
    *.pot

    # Django stuff:
    *.log
    local_settings.py
    db.sqlite3

    # Flask stuff:
    instance/
    .webassets-cache

    # Scrapy stuff:
    .scrapy

    # Sphinx documentation
    docs/_build/

    # PyBuilder
    target/

    # Jupyter Notebook
    .ipynb_checkpoints

    # pyenv
    .python-version

    # celery beat schedule file
    celerybeat-schedule

    # SageMath parsed files
    *.sage.py

    # Environments
    .env
    .venv
    env/
    venv/
    ENV/
    env.bak/
    venv.bak/

    # Spyder project settings
    .spyderproject
    .spyproject

    # Rope project settings
    .ropeproject

    # mkdocs documentation
    /site

    # mypy
    .mypy_cache/" > .gitignore
}

function python-license ()
{
    echo "Copyright (c) 2017, $USER

    All rights reserved.

    Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE." > LISCENSE
}

function python-manifest ()
{
    echo "include LICENSE" > MANIFEST.in
}

function python-make ()
{
    echo "init:
	pip install -r requirements.txt

    test:
	nosetests tests" > Makefile
}

function python-requirements ()
{
    echo "nose
    sphinx" > requirements.txt
}

function python-setup ()
{
    echo "# -*- coding: utf-8 -*-

    # Learn more: https://github.com/kennethreitz/setup.py

    from setuptools import setup, find_packages


    with open('README.md') as f:
        readme = f.read()

    with open('LICENSE') as f:
        license = f.read()

    setup(
    name='sample',
    version='0.1.0',
    description='Sample package for Python-Guide.org',
    long_description=readme,
    author='$USER',
    author_email='your email',
    url='link to your github repo',
    license=license,
    packages=find_packages(exclude=('tests', 'docs'))
    )" > setup.py
}

function sphinx-make ()
{
    echo "# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =
BUILDDIR      = _build

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d \$(BUILDDIR)/doctrees \$(PAPEROPT_\$(PAPER)) \$(SPHINXOPTS) .
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = \$(PAPEROPT_\$(PAPER)) \$(SPHINXOPTS) .

.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext

help:
	@echo \"Please use \`make <target>' where <target> is one of\"
	@echo \"  html       to make standalone HTML files\"
	@echo \"  dirhtml    to make HTML files named index.html in directories\"
	@echo \"  singlehtml to make a single large HTML file\"
	@echo \"  pickle     to make pickle files\"
	@echo \"  json       to make JSON files\"
	@echo \"  htmlhelp   to make HTML files and a HTML help project\"
	@echo \"  qthelp     to make HTML files and a qthelp project\"
	@echo \"  devhelp    to make HTML files and a Devhelp project\"
	@echo \"  epub       to make an epub\"
	@echo \"  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter\"
	@echo \"  latexpdf   to make LaTeX files and run them through pdflatex\"
	@echo \"  text       to make text files\"
	@echo \"  man        to make manual pages\"
	@echo \"  texinfo    to make Texinfo files\"
	@echo \"  info       to make Texinfo files and run them through makeinfo\"
	@echo \"  gettext    to make PO message catalog\s\"
	@echo \"  changes    to make an overview of all changed/added/deprecated items\"
	@echo \"  linkcheck  to check all external links for integrity\"
	@echo \"  doctest    to run all doctests embedded in the documentation (if enabled)\"

clean:
	-rm -rf \$(BUILDDIR)/*

html:
	\$(SPHINXBUILD) -b html \$(ALLSPHINXOPTS) \$(BUILDDIR)/html
	@echo
	@echo \"Build finished. The HTML pages are in \$(BUILDDIR)/html.\"

dirhtml:
	\$(SPHINXBUILD) -b dirhtml \$(ALLSPHINXOPTS) \$(BUILDDIR)/dirhtml
	@echo
	@echo \"Build finished. The HTML pages are in \$(BUILDDIR)/dirhtml.\"

singlehtml:
	\$(SPHINXBUILD) -b singlehtml \$(ALLSPHINXOPTS) \$(BUILDDIR)/singlehtml
	@echo
	@echo \"Build finished. The HTML page is in \$(BUILDDIR)/singlehtml.\"

pickle:
	\$(SPHINXBUILD) -b pickle \$(ALLSPHINXOPTS) \$(BUILDDIR)/pickle
	@echo
	@echo \"Build finished; now you can process the pickle files.\"

json:
	\$(SPHINXBUILD) -b json \$(ALLSPHINXOPTS) \$(BUILDDIR)/json
	@echo
	@echo \"Build finished; now you can process the JSON files.\"

htmlhelp:
	\$(SPHINXBUILD) -b htmlhelp \$(ALLSPHINXOPTS) \$(BUILDDIR)/htmlhelp
	@echo
	@echo \"Build finished; now you can run HTML Help Workshop with the\" \
	      \".hhp project file in \$(BUILDDIR)/htmlhelp.\"

qthelp:
	\$(SPHINXBUILD) -b qthelp \$(ALLSPHINXOPTS) \$(BUILDDIR)/qthelp
	@echo
	@echo \"Build finished; now you can run \"qcollectiongenerator\" with the\" \
	      \".qhcp project file in \$(BUILDDIR)/qthelp, like this:\"
	@echo \"# qcollectiongenerator \$(BUILDDIR)/qthelp/sample.qhcp\"
	@echo \"To view the help file:\"
	@echo \"# assistant -collectionFile \$(BUILDDIR)/qthelp/sample.qhc\"

devhelp:
	\$(SPHINXBUILD) -b devhelp \$(ALLSPHINXOPTS) \$(BUILDDIR)/devhelp
	@echo
	@echo \"Build finished.\"
	@echo \"To view the help file:\"
	@echo \"# mkdir -p $HOME/.local/share/devhelp/sample\"
	@echo \"# ln -s \$(BUILDDIR)/devhelp \$HOME/.local/share/devhelp/sample\"
	@echo \"# devhelp\"

epub:
	\$(SPHINXBUILD) -b epub \$(ALLSPHINXOPTS) \$(BUILDDIR)/epub
	@echo
	@echo \"Build finished. The epub file is in \$(BUILDDIR)/epub.\"

latex:
	\$(SPHINXBUILD) -b latex \$(ALLSPHINXOPTS) \$(BUILDDIR)/latex
	@echo
	@echo \"Build finished; the LaTeX files are in \$(BUILDDIR)/latex.\"
	@echo \"Run \`make' in that directory to run these through (pdf)latex\" \
	      \"(use \`make latexpdf' here to do that automatically).\"

latexpdf:
	\$(SPHINXBUILD) -b latex \$(ALLSPHINXOPTS) \$(BUILDDIR)/latex
	@echo \"Running LaTeX files through pdflatex...\"
	\$(MAKE) -C \$(BUILDDIR)/latex all-pdf
	@echo \"pdflatex finished; the PDF files are in \$(BUILDDIR)/latex.\"

text:
	\$(SPHINXBUILD) -b text \$(ALLSPHINXOPTS) \$(BUILDDIR)/text
	@echo
	@echo \"Build finished. The text files are in \$(BUILDDIR)/text.\"

man:
	\$(SPHINXBUILD) -b man \$(ALLSPHINXOPTS) \$(BUILDDIR)/man
	@echo
	@echo \"Build finished. The manual pages are in \$(BUILDDIR)/man.\"

texinfo:
	\$(SPHINXBUILD) -b texinfo \$(ALLSPHINXOPTS) \$(BUILDDIR)/texinfo
	@echo
	@echo \"Build finished. The Texinfo files are in \$(BUILDDIR)/texinfo.\"
	@echo \"Run \`make' in that directory to run these through makeinfo\" \
	      \"(use \`make info' here to do that automatically).\"

info:
	\$(SPHINXBUILD) -b texinfo \$(ALLSPHINXOPTS) \$(BUILDDIR)/texinfo
	@echo \"Running Texinfo files through makeinfo...\"
	make -C \$(BUILDDIR)/texinfo info
	@echo \"makeinfo finished; the Info files are in \$(BUILDDIR)/texinfo.\"

gettext:
	\$(SPHINXBUILD) -b gettext \$(I18NSPHINXOPTS) \$(BUILDDIR)/locale
	@echo
	@echo \"Build finished. The message catalogs are in \$(BUILDDIR)/locale.\"

changes:
	\$(SPHINXBUILD) -b changes \$(ALLSPHINXOPTS) \$(BUILDDIR)/changes
	@echo
	@echo \"The overview file is in \$(BUILDDIR)/changes.\"

linkcheck:
	\$(SPHINXBUILD) -b linkcheck \$(ALLSPHINXOPTS) \$(BUILDDIR)/linkcheck
	@echo
	@echo \"Link check complete; look for any errors in the above output \" \
	      \"or in \$(BUILDDIR)/linkcheck/output.txt.\"

doctest:
	\$(SPHINXBUILD) -b doctest \$(ALLSPHINXOPTS) \$(BUILDDIR)/doctest
	@echo \"Testing of doctests in the sources finished, look at the \" \
	      \"results in \$(BUILDDIR)/doctest/output.txt.\"" > Makefile
}


function python-conf ()
{
    echo "# -*- coding: utf-8 -*-
    #
    # sample documentation build configuration file, created by
    # sphinx-quickstart on Mon Apr 16 21:22:43 2012.
    #
    # This file is execfile()d with the current directory set to its containing dir.
    #
    # Note that not all possible configuration values are present in this
    # autogenerated file.
    #
    # All configuration values have a default; values that are commented out
    # serve to show the default.

    import sys, os

    # If extensions (or modules to document with autodoc) are in another directory,
    # add these directories to sys.path here. If the directory is relative to the
    # documentation root, use os.path.abspath to make it absolute, like shown here.
    #sys.path.insert(0, os.path.abspath('.'))

    # -- General configuration -----------------------------------------------------

    # If your documentation needs a minimal Sphinx version, state it here.
    #needs_sphinx = '1.0'

    # Add any Sphinx extension module names here, as strings. They can be extensions
    # coming with Sphinx (named 'sphinx.ext.*') or your custom ones.
    extensions = []

    # Add any paths that contain templates here, relative to this directory.
    templates_path = ['_templates']

    # The suffix of source filenames.
    source_suffix = '.rst'

    # The encoding of source files.
    #source_encoding = 'utf-8-sig'

    # The master toctree document.
    master_doc = 'index'

    # General information about the project.
    project = u'sample'
    copyright = u'2012, Kenneth Reitz'

    # The version info for the project you're documenting, acts as replacement for
    # |version| and |release|, also used in various other places throughout the
    # built documents.
    #
    # The short X.Y version.
    version = 'v0.0.1'
    # The full version, including alpha/beta/rc tags.
    release = 'v0.0.1'

    # The language for content autogenerated by Sphinx. Refer to documentation
    # for a list of supported languages.
    #language = None

    # There are two options for replacing |today|: either, you set today to some
    # non-false value, then it is used:
    #today = ''
    # Else, today_fmt is used as the format for a strftime call.
    #today_fmt = '%B %d, %Y'

    # List of patterns, relative to source directory, that match files and
    # directories to ignore when looking for source files.
    exclude_patterns = ['_build']

    # The reST default role (used for this markup: `text`) to use for all documents.
    #default_role = None

    # If true, '()' will be appended to :func: etc. cross-reference text.
    #add_function_parentheses = True

    # If true, the current module name will be prepended to all description
    # unit titles (such as .. function::).
    #add_module_names = True

    # If true, sectionauthor and moduleauthor directives will be shown in the
    # output. They are ignored by default.
    #show_authors = False

    # The name of the Pygments (syntax highlighting) style to use.
    pygments_style = 'sphinx'

    # A list of ignored prefixes for module index sorting.
    #modindex_common_prefix = []


    # -- Options for HTML output ---------------------------------------------------

    # The theme to use for HTML and HTML Help pages.  See the documentation for
    # a list of builtin themes.
    html_theme = 'default'

    # Theme options are theme-specific and customize the look and feel of a theme
    # further.  For a list of options available for each theme, see the
    # documentation.
    #html_theme_options = {}

    # Add any paths that contain custom themes here, relative to this directory.
    #html_theme_path = []

    # The name for this set of Sphinx documents.  If None, it defaults to
    # \"<project> v<release> documentation\".
    #html_title = None

    # A shorter title for the navigation bar.  Default is the same as html_title.
    #html_short_title = None

    # The name of an image file (relative to this directory) to place at the top
    # of the sidebar.
    #html_logo = None

    # The name of an image file (within the static path) to use as favicon of the
    # docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
    # pixels large.
    #html_favicon = None

    # Add any paths that contain custom static files (such as style sheets) here,
    # relative to this directory. They are copied after the builtin static files,
    # so a file named \"default.css\" will overwrite the builtin \"default.css\".
    html_static_path = ['_static']

    # If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
    # using the given strftime format.
    #html_last_updated_fmt = '%b %d, %Y'

    # If true, SmartyPants will be used to convert quotes and dashes to
    # typographically correct entities.
    #html_use_smartypants = True

    # Custom sidebar templates, maps document names to template names.
    #html_sidebars = {}

    # Additional templates that should be rendered to pages, maps page names to
    # template names.
    #html_additional_pages = {}

    # If false, no module index is generated.
    #html_domain_indices = True

    # If false, no index is generated.
    #html_use_index = True

    # If true, the index is split into individual pages for each letter.
    #html_split_index = False

    # If true, links to the reST sources are added to the pages.
    #html_show_sourcelink = True

    # If true, \"Created using Sphinx\" is shown in the HTML footer. Default is True.
    #html_show_sphinx = True

    # If true, \"(C) Copyright ...\" is shown in the HTML footer. Default is True.
    #html_show_copyright = True

    # If true, an OpenSearch description file will be output, and all pages will
    # contain a <link> tag referring to it.  The value of this option must be the
    # base URL from which the finished HTML is served.
    #html_use_opensearch = ''

    # This is the file name suffix for HTML files (e.g. \".xhtml\").
    #html_file_suffix = None

    # Output file base name for HTML help builder.
    htmlhelp_basename = 'sampledoc'


    # -- Options for LaTeX output --------------------------------------------------

    latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    #'papersize': 'letterpaper',

    # The font size ('10pt', '11pt' or '12pt').
    #'pointsize': '10pt',

    # Additional stuff for the LaTeX preamble.
    #'preamble': '',
    }

    # Grouping the document tree into LaTeX files. List of tuples
    # (source start file, target name, title, author, documentclass [howto/manual]).
    latex_documents = [
    ('index', 'sample.tex', u'sample Documentation',
    u'Kenneth Reitz', 'manual'),
    ]

    # The name of an image file (relative to this directory) to place at the top of
    # the title page.
    #latex_logo = None

    # For \"manual\" documents, if this is true, then toplevel headings are parts,
    # not chapters.
    #latex_use_parts = False

    # If true, show page references after internal links.
    #latex_show_pagerefs = False

    # If true, show URL addresses after external links.
    #latex_show_urls = False

    # Documents to append as an appendix to all manuals.
    #latex_appendices = []

    # If false, no module index is generated.
    #latex_domain_indices = True


    # -- Options for manual page output --------------------------------------------

    # One entry per manual page. List of tuples
    # (source start file, name, description, authors, manual section).
    man_pages = [
        ('index', 'sample', u'sample Documentation',
        [u'$USER'], 1)
    ]

    # If true, show URL addresses after external links.
    #man_show_urls = False


    # -- Options for Texinfo output ------------------------------------------------

    # Grouping the document tree into Texinfo files. List of tuples
    # (source start file, target name, title, author,
    #  dir menu entry, description, category)
    texinfo_documents = [
    ('index', 'sample', u'sample Documentation',
    u'$USER', 'sample', 'One line description of project.',
    'Miscellaneous'),
    ]

    # Documents to append as an appendix to all manuals.
    #texinfo_appendices = []

    # If false, no module index is generated.
    #texinfo_domain_indices = True

    # How to display URL addresses: 'footnote', 'no', or 'inline'.
    #texinfo_show_urls = 'footnote'" > conf.py
}

function python-bat ()
{
    echo "@ECHO OFF

    REM Command file for Sphinx documentation

    if \"%SPHINXBUILD%\" == \"\" (
        set SPHINXBUILD=sphinx-build
    )
    set BUILDDIR=_build
    set ALLSPHINXOPTS=-d %BUILDDIR%/doctrees %SPHINXOPTS% .
    set I18NSPHINXOPTS=%SPHINXOPTS% .
    if NOT \"%PAPER%\" == \"\" (
        set ALLSPHINXOPTS=-D latex_paper_size=%PAPER% %ALLSPHINXOPTS%
        set I18NSPHINXOPTS=-D latex_paper_size=%PAPER% %I18NSPHINXOPTS%
    )

    if \"%1\" == \"\" goto help

    if \"%1\" == \"help\" (
        :help
        echo.  Please use \`make ^\<target^\>\` where ^<target^> is one of
        echo.  html       to make standalone HTML files
        echo.  dirhtml    to make HTML files named index.html in directories
        echo.  singlehtml to make a single large HTML file
        echo.  pickle     to make pickle files
        echo.  json       to make JSON files
        echo.  htmlhelp   to make HTML files and a HTML help project
        echo.  qthelp     to make HTML files and a qthelp project
        echo.  devhelp    to make HTML files and a Devhelp project
        echo.  epub       to make an epub
        echo.  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter
        echo.  text       to make text files
        echo.  man        to make manual pages
        echo.  texinfo    to make Texinfo files
        echo.  gettext    to make PO message catalogs
        echo.  changes    to make an overview over all changed/added/deprecated items
        echo.  linkcheck  to check all external links for integrity
        echo.  doctest    to run all doctests embedded in the documentation if enabled
        goto end
    )

    if \"%1\" == \"clean\" (
        for /d %%i in (%BUILDDIR%\*) do rmdir /q /s %%i
        del /q /s %BUILDDIR%\*
        goto end
    )

    if \"%1\" == \"html\" (
        %SPHINXBUILD% -b html %ALLSPHINXOPTS% %BUILDDIR%/html
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The HTML pages are in %BUILDDIR%/html.
        goto end
    )

    if \"%1\" == \"dirhtml\" (
        %SPHINXBUILD% -b dirhtml %ALLSPHINXOPTS% %BUILDDIR%/dirhtml
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The HTML pages are in %BUILDDIR%/dirhtml.
        goto end
    )

    if \"%1\" == \"singlehtml\" (
        %SPHINXBUILD% -b singlehtml %ALLSPHINXOPTS% %BUILDDIR%/singlehtml
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The HTML pages are in %BUILDDIR%/singlehtml.
        goto end
    )

    if \"%1\" == \"pickle\" (
        %SPHINXBUILD% -b pickle %ALLSPHINXOPTS% %BUILDDIR%/pickle
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished; now you can process the pickle files.
        goto end
    )

    if \"%1\" == \"json\" (
        %SPHINXBUILD% -b json %ALLSPHINXOPTS% %BUILDDIR%/json
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished; now you can process the JSON files.
        goto end
    )

    if \"%1\" == \"htmlhelp\" (
        %SPHINXBUILD% -b htmlhelp %ALLSPHINXOPTS% %BUILDDIR%/htmlhelp
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished; now you can run HTML Help Workshop with the ^
    .hhp project file in %BUILDDIR%/htmlhelp.
        goto end
    )

    if \"%1\" == \"qthelp\" (
        %SPHINXBUILD% -b qthelp %ALLSPHINXOPTS% %BUILDDIR%/qthelp
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished; now you can run \"qcollectiongenerator\" with the ^
    .qhcp project file in %BUILDDIR%/qthelp, like this:
        echo.^> qcollectiongenerator %BUILDDIR%\qthelp\sample.qhcp
        echo.To view the help file:
        echo.^> assistant -collectionFile %BUILDDIR%\qthelp\sample.ghc
        goto end
    )

    if \"%1\" == \"devhelp\" (
        %SPHINXBUILD% -b devhelp %ALLSPHINXOPTS% %BUILDDIR%/devhelp
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished.
        goto end
    )

    if \"%1\" == \"epub\" (
        %SPHINXBUILD% -b epub %ALLSPHINXOPTS% %BUILDDIR%/epub
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The epub file is in %BUILDDIR%/epub.
        goto end
    )

    if \"%1\" == \"latex\" (
        %SPHINXBUILD% -b latex %ALLSPHINXOPTS% %BUILDDIR%/latex
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished; the LaTeX files are in %BUILDDIR%/latex.
        goto end
    )

    if \"%1\" == \"text\" (
        %SPHINXBUILD% -b text %ALLSPHINXOPTS% %BUILDDIR%/text
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The text files are in %BUILDDIR%/text.
        goto end
    )

    if \"%1\" == \"man\" (
        %SPHINXBUILD% -b man %ALLSPHINXOPTS% %BUILDDIR%/man
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The manual pages are in %BUILDDIR%/man.
        goto end
    )

    if \"%1\" == \"texinfo\" (
        %SPHINXBUILD% -b texinfo %ALLSPHINXOPTS% %BUILDDIR%/texinfo
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The Texinfo files are in %BUILDDIR%/texinfo.
        goto end
    )

    if \"%1\" == \"gettext\" (
        %SPHINXBUILD% -b gettext %I18NSPHINXOPTS% %BUILDDIR%/locale
        if errorlevel 1 exit /b 1
        echo.
        echo.Build finished. The message catalogs are in %BUILDDIR%/locale.
        goto end
    )

    if \"%1\" == \"changes\" (
        %SPHINXBUILD% -b changes %ALLSPHINXOPTS% %BUILDDIR%/changes
        if errorlevel 1 exit /b 1
        echo.
        echo.The overview file is in %BUILDDIR%/changes.
        goto end
    )

    if \"%1\" == \"linkcheck\" (
        %SPHINXBUILD% -b linkcheck %ALLSPHINXOPTS% %BUILDDIR%/linkcheck
        if errorlevel 1 exit /b 1
        echo.
        echo.Link check complete; look for any errors in the above output ^
    or in %BUILDDIR%/linkcheck/output.txt.
        goto end
    )

    if \"%1\" == \"doctest\" (
        %SPHINXBUILD% -b doctest %ALLSPHINXOPTS% %BUILDDIR%/doctest
        if errorlevel 1 exit /b 1
        echo.
        echo.Testing of doctests in the sources finished, look at the ^
    results in %BUILDDIR%/doctest/output.txt.
        goto end
    )

    :end" > make.bat
}

function python-init-sample ()
{
    echo "from .core import hmm" > __init__.py
}

function python-core ()
{
    echo "# -*- coding: utf-8 -*-
    from . import helpers

    def get_hmm():
        """Get a thought."""
        return 'hmmm...'


    def hmm():
        """Contemplation..."""
        if helpers.get_answer():
            print(get_hmm())" > core.py
}

function python-helpers ()
{
    echo "def get_answer():
    \"\"\"Get an answer.\"\"\"
    return True" > helpers.py
}

function python-init-tests ()
{
    echo "" > __init.py
}

function python-context ()
{
    echo "
    # -*- coding: utf-8 -*-

    import sys
    import os
    sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

    import sample" > context.py
}

function python-test-basic ()
{
    echo "# -*- coding: utf-8 -*-

    from .context import sample

    import unittest


    class BasicTestSuite(unittest.TestCase):
        """Basic test cases."""

        def test_absolute_truth_and_meaning(self):
            assert True


    if __name__ == '__main__':
        unittest.main()" > test_basic.py
}

function python-test-advanced ()
{
    echo "# -*- coding: utf-8 -*-

    from .context import sample

    import unittest


    class AdvancedTestSuite(unittest.TestCase):
        """Advanced test cases."""

        def test_thoughts(self):
            self.assertIsNone(sample.hmm())


    if __name__ == '__main__':
        unittest.main()" > test_advanced.py
}