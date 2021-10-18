class Text {
  String _textTitle = " ";

  get textTitle => this._textTitle;

  set textTitle(value) => this._textTitle = value;

  void setText(String header) {
    this._textTitle = header;
  }

  String getText() {
    return this._textTitle;
  }
}
