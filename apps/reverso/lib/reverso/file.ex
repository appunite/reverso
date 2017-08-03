defmodule Reverso.File do

  def content do
    ~s(<xliff xmlns="urn:oasis:names:tc:xliff:document:2.0" version="2.0"
srcLang="en-US" trgLang="ja-JP">
  <file id="f1" original="Graphic Example.psd">
  <skeleton href="Graphic Example.psd.skl"/>
    <unit id="1">
      <segment>
        <source>Quetzal</source>
        <target>Quetzal</target>
      </segment>
    </unit>
    <unit id="2">
      <segment>
        <source>An application to manipulate and process XLIFF documents</source>
        <target>XLIFF 文書を編集、または処理 するアプリケーションです。</target>
      </segment>
    </unit>
    <unit id="3">
      <segment>
        <source>XLIFF Data Manager</source>
        <target>XLIFF データ・マネージャ</target>
      </segment>
    </unit>
  </file>
</xliff>)
  end
end
