<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="table">
        <xsl:copy>
            <xsl:attribute name="class">table table-bordered w-auto</xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ul|ol">
        <xsl:copy>
            <xsl:attribute name="class">list-group</xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="li|dt|dd">
        <xsl:copy>
            <xsl:attribute name="class">list-group-item</xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="h2|h3|h4|h5|h6">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="h1">
        <xsl:element name="h1">
            <xsl:element name="span">
                <xsl:attribute name="class">badge badge-secondary</xsl:attribute>
                <xsl:apply-templates />
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="section">
        <xsl:param name="moodle-player-course-id" />
        <xsl:variable name="section-number" select="count(preceding-sibling::*[name() = name(current())]) + 2" />
        <xsl:element name="section">
            <xsl:attribute name="class">shadow p-3 mb-5 bg-white rounded</xsl:attribute>
            <!--
                The target should reach the section but the static navbar create ann offset.
                This div will be hidden and positionned to compensate for the navbar
            -->
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id()" />
                </xsl:attribute>
            </xsl:element>
            <xsl:apply-templates />
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="concat(generate-id(), '-moodle-button')" />
                </xsl:attribute>
                <xsl:attribute name="class">anchor-moodle-button</xsl:attribute>
            </xsl:element>
            <xsl:element name="div">
                <xsl:element name="a">
                    <xsl:attribute name="class">btn btn-outline-dark</xsl:attribute>
                    <xsl:attribute name="target">_moodle-tab</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="concat('/course/view.php?id=', $moodle-player-course-id, '&amp;section=', $section-number)" />
                    </xsl:attribute>
                    Moodle
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="article">
        <xsl:element name="article">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="*[name()='h2']">
                        <xsl:value-of select="'contain-h2'" />
                    </xsl:when>
                    <xsl:when test="*[name()='h3']">
                        <xsl:value-of select="'contain-h3'" />
                    </xsl:when>
                    <xsl:when test="*[name()='h4']">
                        <xsl:value-of select="'contain-h4'" />
                    </xsl:when>
                    <xsl:when test="*[name()='h5']">
                        <xsl:value-of select="'contain-h5'" />
                    </xsl:when>
                    <xsl:when test="*[name()='h6']">
                        <xsl:value-of select="'contain-h6'" />
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <!--
                The target should reach the section but the static navbar create ann offset.
                This div will be hidden and positionned to compensate for the navbar
            -->
            <xsl:element name="div">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id()" />
                </xsl:attribute>
            </xsl:element>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
    <xsl:template match="pre[ code ]">
        <xsl:variable name="generatedId" select="generate-id()" />
        <div class="card">
            <div class="card-body">
                <xsl:if test="code/@data-title">
                    <h5 class="card-title">
                        <xsl:value-of select="code/@data-title" />
                    </h5>
                </xsl:if>
                <xsl:if test="code/@data-subtitle">
                    <h6 class="card-subtitle mb-2 text-muted">
                        <xsl:value-of select="code/@data-subtitle" />
                    </h6>
                </xsl:if>
                <xsl:copy>
                    <xsl:attribute name="id"><xsl:value-of select="concat('code_snippet_', $generatedId)" /></xsl:attribute>
                    <xsl:copy-of select="./code" />
                </xsl:copy>

                <button class="btn noprint" data-clipboard-target="#code_snippet_{$generatedId}">
                    Copy
                </button>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="img">
        <div class="card">
            <div class="card-body">
                <xsl:if test="@data-title">
                    <h5 class="card-title">
                        <xsl:value-of select="@data-title" />
                    </h5>
                </xsl:if>
                <xsl:if test="@data-subtitle">
                    <h6 class="card-subtitle mb-2 text-muted">
                        <xsl:value-of select="@data-subtitle" />
                    </h6>
                </xsl:if>
                <div class="card-body-img">
                    <xsl:copy-of select="." />
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="a">
        <xsl:copy>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>