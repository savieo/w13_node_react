<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="moodle-player-folder" select="/html/head/meta[@name='moodle-player-folder']/@content" />
    <xsl:variable name="moodle-player-course-id" select="/html/head/meta[@name='moodle-player-course-id']/@content" />
    <xsl:variable name="moodle-player-code-style" select="/html/head/meta[@name='moodle-player-code-style']/@content" />
    <xsl:variable name="version" select="document('version.xml')" />
    <xsl:variable name="course-version" select="document('../course-version.xml')" />
    <xsl:strip-space elements="pre" />
    <xsl:key name="referenceLink" match="a" use="." />
    <xsl:include href="html.xslt" />
    <xsl:output method="html" doctype-system="about:legacy-compat" />
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="html">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="head">
        <xsl:element name="head">
            <xsl:element name="title">
                <xsl:value-of select="title" />
            </xsl:element>
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <xsl:call-template name="link">
                <xsl:with-param name="path" select="'/lib/bootstrap/css/bootstrap.min.css'" />
            </xsl:call-template>
            <xsl:call-template name="link">
                <xsl:with-param name="path" select="concat('/lib/highlight/styles/', $moodle-player-code-style, '.css')" />
            </xsl:call-template>
            <xsl:call-template name="link">
                <xsl:with-param name="path" select="'/moodle-player.css'" />
            </xsl:call-template>
            <xsl:call-template name="script">
                <xsl:with-param name="path" select="'/lib/jquery/jquery-3.3.1.min.js'" />
            </xsl:call-template>
            <xsl:call-template name="script">
                <xsl:with-param name="path" select="'/lib/bootstrap/js/bootstrap.min.js'" />
            </xsl:call-template>
            <xsl:call-template name="script">
                <xsl:with-param name="path" select="'/lib/highlight/highlight.pack.js'" />
            </xsl:call-template>
            <xsl:call-template name="script">
                <xsl:with-param name="path" select="'/lib/clipboard/clipboard.min.js'" />
            </xsl:call-template>
            <link rel="apple-touch-icon" sizes="57x57" href="{$moodle-player-folder}/favicon/apple-icon-57x57.png" />
            <link rel="apple-touch-icon" sizes="60x60" href="{$moodle-player-folder}/favicon/apple-icon-60x60.png" />
            <link rel="apple-touch-icon" sizes="72x72" href="{$moodle-player-folder}/favicon/apple-icon-72x72.png" />
            <link rel="apple-touch-icon" sizes="76x76" href="{$moodle-player-folder}/favicon/apple-icon-76x76.png" />
            <link rel="apple-touch-icon" sizes="114x114" href="{$moodle-player-folder}/favicon/apple-icon-114x114.png" />
            <link rel="apple-touch-icon" sizes="120x120" href="{$moodle-player-folder}/favicon/apple-icon-120x120.png" />
            <link rel="apple-touch-icon" sizes="144x144" href="{$moodle-player-folder}/favicon/apple-icon-144x144.png" />
            <link rel="apple-touch-icon" sizes="152x152" href="{$moodle-player-folder}/favicon/apple-icon-152x152.png" />
            <link rel="apple-touch-icon" sizes="180x180" href="{$moodle-player-folder}/favicon/apple-icon-180x180.png" />
            <link rel="icon" type="image/png" sizes="192x192" href="{$moodle-player-folder}/favicon/android-icon-192x192.png" />
            <link rel="icon" type="image/png" sizes="32x32" href="{$moodle-player-folder}/favicon/favicon-32x32.png" />
            <link rel="icon" type="image/png" sizes="96x96" href="{$moodle-player-folder}/favicon/favicon-96x96.png" />
            <link rel="icon" type="image/png" sizes="16x16" href="{$moodle-player-folder}/favicon/favicon-16x16.png" />
            <link rel="manifest" href="{$moodle-player-folder}/favicon/manifest.json" />
            <meta name="msapplication-TileColor" content="#ffffff" />
            <meta name="msapplication-TileImage" content="{$moodle-player-folder}/favicon/ms-icon-144x144.png" />
            <meta name="theme-color" content="#ffffff" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template name="link">
        <xsl:param name="path" />
        <xsl:element name="link">
            <xsl:attribute name="rel">stylesheet</xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="$moodle-player-folder" />
                <xsl:value-of select="$path" />
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    <xsl:template name="script">
        <xsl:param name="path" />
        <xsl:element name="script">
            <xsl:attribute name="src">
                <xsl:value-of select="$moodle-player-folder" />
                <xsl:value-of select="$path" />
            </xsl:attribute>
            <xsl:value-of select="' '" />
        </xsl:element>
    </xsl:template>
    <xsl:template name="navbar">
        <xsl:param name="title" />
        <xsl:param name="reference-label" />
        <xsl:param name="section" />
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggler" aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarToggler">
                <ul class="nav nav-pills mr-auto">
                    <li class="nav-item">
                        <a class="nav-link active" id="course-tab" data-toggle="tab" href="#course" aria-controls="course" aria-selected="true">
                            <xsl:value-of select="$title" />
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="reference-tab" data-toggle="tab" href="#reference" aria-controls="reference" aria-selected="false">References</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="source-tab" data-toggle="tab" href="#source" aria-controls="source" aria-selected="false">Sources</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Section</a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-scroll">
                            <xsl:for-each select="//section">
                                <xsl:variable name="section-number" select="count(preceding-sibling::*[name() = name(current())]) + 2" />
                                <xsl:element name="a">
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="'dropdown-item'" />
                                        <xsl:value-of select="' badge-secondary'" />
                                    </xsl:attribute>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat('#', generate-id())" />
                                    </xsl:attribute>
                                    <xsl:value-of select="h1/." />
                                </xsl:element>
                                <xsl:for-each select="article[h2]">
                                    <xsl:element name="a">
                                        <xsl:attribute name="class">
                                            <xsl:value-of select="'dropdown-item'" />
                                        </xsl:attribute>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="concat('#', generate-id())" />
                                        </xsl:attribute>
                                        <!-- There should be a h2 as first child -->
                                        <xsl:value-of select="*[1]/." />
                                    </xsl:element>
                                </xsl:for-each>
                                <xsl:element name="a">
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="'dropdown-item'" />
                                    </xsl:attribute>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="concat('/course/view.php?id=', $moodle-player-course-id, '&amp;section=', $section-number)" />
                                    </xsl:attribute>
                                    <xsl:attribute name="target">_moodle-tab</xsl:attribute>
                                    <xsl:value-of select="'- Moodle'" />
                                </xsl:element>
                            </xsl:for-each>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
    </xsl:template>
    <xsl:template match="body">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:call-template name="navbar">
                <xsl:with-param name="title" select="../head/title" />
            </xsl:call-template>
            <xsl:element name="main">
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="course" role="tabpanel" aria-labelledby="course-tab">
                        <xsl:apply-templates>
                            <xsl:with-param name="moodle-player-course-id" select="$moodle-player-course-id" />
                        </xsl:apply-templates>
                    </div>
                    <div class="tab-pane fade" id="reference" role="tabpanel" aria-labelledby="reference-tab">
                        <xsl:call-template name="reference" />
                    </div>
                    <div class="tab-pane fade" id="source" role="tabpanel" aria-labelledby="source-tab">
                        <xsl:call-template name="source" />
                    </div>
                </div>
            </xsl:element>
            <script>
                <xsl:text disable-output-escaping="yes">
                    <![CDATA[
                        $(document).ready(function () {
                            const codeNodeList = document.querySelectorAll("pre > code");
                            codeNodeList.forEach(function(codeNode) {
                                try {
                                    const codeArray = codeNode.innerHTML.split('\n');
console.log(codeArray);
                                    // If the CDATA element is not formatted on a single line: ![CDATA[ example ]]
                                    // And if the CDATA element is formatted on his own line, remove the white space line
                                    if (codeArray.length > 1 && !codeArray[1].replace(/\s/g, '').length) {
                                        codeArray.splice(0,1);
                                        codeArray[0] = codeArray[0].trim();
                                    }

                                    const codeText = codeArray.join('\n');

                                    const pattern = codeText.match(/\s*\n[\t\s]*/);
                                    codeNode.innerHTML = codeText.replace(new RegExp(pattern, "g"), '\n');

                                    hljs.highlightBlock(codeNode);
                                } catch (error) {
                                    console.log('Error while parsing and initializing syntaxe highlight:', error);
                                }
                            });

                            new ClipboardJS('.btn');
                        });
                    ]]>
                </xsl:text>
            </script>
            <xsl:call-template name="version" />
        </xsl:copy>
    </xsl:template>
    <xsl:template name="version">
        <details>
            <summary>Version</summary>
            <h3>
                <xsl:value-of select="$course-version//version/project/@name" />
            </h3>
            <ul>
                <li>
                    Version:
                    <xsl:value-of select="$course-version//version/project/@version" />
                </li>
                <li>
                    Date:
                    <xsl:value-of select="$course-version//version/project/@date" />
                </li>
                <li>
                    Description:
                    <xsl:value-of select="$course-version//version/project" />
                </li>
            </ul>
            <h3>
                <xsl:value-of select="$version//version/project/@name" />
            </h3>
            <ul>
                <li>
                    Version:
                    <xsl:value-of select="$version//version/project/@version" />
                </li>
                <li>
                    Date:
                    <xsl:value-of select="$version//version/project/@date" />
                </li>
                <li>
                    Description:
                    <xsl:value-of select="$version//version/project" />
                </li>
            </ul>
        </details>
    </xsl:template>
    <xsl:template name="reference">
        <xsl:element name="ul">
            <xsl:for-each select="//section">
                <li>
                    <xsl:element name="h1">
                        <xsl:element name="span">
                            <xsl:attribute name="class">badge badge-secondary</xsl:attribute>
                            <xsl:value-of select="h1" />
                        </xsl:element>
                    </xsl:element>
                    <ul>
                        <xsl:for-each select=".//a">
                            <li>
                                <xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="@href" />
                                    </xsl:attribute>
                                    <xsl:attribute name="target">_blank</xsl:attribute>
                                    <xsl:value-of select="." />
                                </xsl:element>
                            </li>
                        </xsl:for-each>
                    </ul>
                </li>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    <xsl:template name="source">
        <xsl:for-each select="//section">
            <xsl:variable name="i" select="position()" />
            <section>
                <xsl:element name="h1">
                    <xsl:element name="span">
                        <xsl:attribute name="class">badge badge-secondary</xsl:attribute>
                        <xsl:value-of select="h1" />
                    </xsl:element>
                </xsl:element>
                <xsl:for-each select="article">
                    <xsl:variable name="j" select="position()" />
                    <xsl:element name="article">
                        <xsl:attribute name="class">contain-h2</xsl:attribute>
                        <xsl:element name="h2">
                            <xsl:element name="span">
                                <xsl:attribute name="class">badge badge-secondary</xsl:attribute>
                                <xsl:value-of select="h2" />
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                    <xsl:for-each select="pre">
                        <xsl:variable name="k" select="position()" />
                        <xsl:element name="article">
                            <xsl:attribute name="class">contain-h3</xsl:attribute>
                            <!-- please kill me as soon as -->
                            <div></div>
                            <xsl:element name="div">
                                <xsl:attribute name="class">card</xsl:attribute>
                                <xsl:element name="div">
                                    <xsl:attribute name="class">card-body</xsl:attribute>
                                    <xsl:element name="h3">
                                        <xsl:attribute name="class">card-title</xsl:attribute>
                                        <xsl:value-of select="code/@data-title" />
                                    </xsl:element>
                                    <xsl:element name="h4">
                                        <xsl:attribute name="class">card-subtitle</xsl:attribute>
                                        <xsl:value-of select="code/@data-subtitle" />
                                    </xsl:element>
                                    <xsl:element name="pre">
                                        <xsl:attribute name="id"><xsl:value-of select="concat('code_snippet_', $i, '_', $j, '_', $k)" /></xsl:attribute>
                                        <xsl:element name="code">
                                            <xsl:attribute name="class">
                                                <xsl:value-of select="code/@class" />
                                            </xsl:attribute>
                                            <xsl:value-of select="./code" />
                                        </xsl:element>
                                    </xsl:element>
                                    <xsl:element name="button">
                                        <xsl:attribute name="class">btn noprint</xsl:attribute>
                                        <xsl:attribute name="data-clipboard-action">copy</xsl:attribute>
                                        <xsl:attribute name="data-clipboard-target"><xsl:value-of select="concat('#code_snippet_', $i, '_', $j, '_', $k)" /></xsl:attribute>
                                        Copy
                                    </xsl:element>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </section>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>