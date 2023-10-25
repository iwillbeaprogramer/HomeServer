from PySide6.QtWidgets import QMainWindow,QPushButton,QPlainTextEdit,QVBoxLayout,QHBoxLayout,QFrame


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.terminal = QPlainTextEdit()
        self.terminal.setReadOnly(True)
        self.one_cartoon_upload_button_zip = QPushButton("One-Cartoon-zip")
        self.one_cartoon_upload_button = QPushButton("One-Cartoon")
        self.many_cartoon_upload_button = QPushButton("Many-Cartoon")
        self.layout_ = QVBoxLayout()
        self.button_layout = QHBoxLayout()
        self.button_layout.addWidget(self.one_cartoon_upload_button_zip)
        self.button_layout.addWidget(self.one_cartoon_upload_button)
        self.button_layout.addWidget(self.many_cartoon_upload_button)
        self.layout_.addWidget(self.terminal)
        self.layout_.addLayout(self.button_layout)
        self.main_widget = QFrame()
        self.main_widget.setLayout(self.layout_)
        self.setCentralWidget(self.main_widget)