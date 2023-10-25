from PySide6.QtWidgets import QApplication
from qt_material import apply_stylesheet
from GUI import MainWindow
import sys

def main():
    app = QApplication(sys.argv)
    apply_stylesheet(app,theme="light_purple.xml")
    widget = MainWindow()
    widget.setGeometry(600,400,640,480)
    widget.show()
    sys.exit(app.exec())

if __name__=="__main__":
    main()