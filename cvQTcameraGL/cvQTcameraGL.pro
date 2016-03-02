QT += core gui opengl

contains(QT_VERSION, ^5\\.[0-8]\\..*) {
    message("* Using Qt $${QT_VERSION}.")
    QT += widgets

    # On my system I have to specify g++ as compiler else it will use clang++ by default
    #QMAKE_CXX=g++
    #QMAKE_CC=gcc
}

SOURCES += \
    main.cpp \
    widget.cpp

HEADERS += \
    widget.h

## OpenCV settings for Unix/Linux
unix:!mac {
    message("* Using settings for Unix/Linux.")
    INCLUDEPATH += /usr/local/include/opencv

    LIBS += -L/usr/local/lib/ \
        -lopencv_core \
        -lopencv_highgui \
        -lopencv_imgproc
}

## OpenCV settings for Mac OS X with OpenCV 3.1
macx {
    message("* Using settings for Mac OS X.")

    # Solve imwrite() undefined symbol
    QMAKE_CXXFLAGS += -stdlib=libc++

    INCLUDEPATH += "/usr/local/opt/opencv3/include"

    LIBS += -L"/usr/local/opt/opencv3/lib" \
        -lopencv_core \
        -lopencv_highgui \
        -lopencv_imgproc \
        -lopencv_imgcodecs \
        -lopencv_videoio \
        -lc++
}

## OpenCV settings for Windows and OpenCV 2.4.2
win32 {
    message("* Using settings for Windows.")
    INCLUDEPATH += "C:\\opencv\\build\\include" \
                   "C:\\opencv\\build\\include\\opencv" \
                   "C:\\opencv\\build\\include\\opencv2"

    CONFIG(debug, debug | release) {
        LIBS += -L"C:\\opencv\\build\\x86\\vc10\\lib" \
            -lopencv_core248d \
            -lopencv_highgui248d \
            -lopencv_imgproc248d
    }

    CONFIG(release, debug | release) {
        LIBS += -L"C:\\opencv\\build\\x86\\vc10\\lib" \
            -lopencv_core248 \
            -lopencv_highgui248 \
            -lopencv_imgproc248
    }
}

