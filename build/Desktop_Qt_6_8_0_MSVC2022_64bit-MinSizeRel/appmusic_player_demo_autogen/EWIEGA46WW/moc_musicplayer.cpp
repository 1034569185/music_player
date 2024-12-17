/****************************************************************************
** Meta object code from reading C++ file 'musicplayer.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../musicplayer.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'musicplayer.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.8.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSMusicPlayerENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSMusicPlayerENDCLASS = QtMocHelpers::stringData(
    "MusicPlayer",
    "QML.Element",
    "auto",
    "isPausedChanged",
    "",
    "metaDataChanged",
    "volumeChanged",
    "lastVolumeChanged",
    "onInitializationDone",
    "m_play",
    "m_pause",
    "m_stop",
    "m_setSource",
    "source",
    "getMetaData",
    "QMediaMetaData",
    "isPaused",
    "name",
    "artist",
    "duration",
    "coverImage",
    "volume",
    "lastVolume"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSMusicPlayerENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       1,   14, // classinfo
      10,   16, // methods
       7,   88, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // classinfo: key, value
       1,    2,

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       3,    0,   76,    4, 0x06,    8 /* Public */,
       5,    0,   77,    4, 0x06,    9 /* Public */,
       6,    0,   78,    4, 0x06,   10 /* Public */,
       7,    0,   79,    4, 0x06,   11 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       8,    0,   80,    4, 0x0a,   12 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       9,    0,   81,    4, 0x02,   13 /* Public */,
      10,    0,   82,    4, 0x02,   14 /* Public */,
      11,    0,   83,    4, 0x02,   15 /* Public */,
      12,    1,   84,    4, 0x02,   16 /* Public */,
      14,    0,   87,    4, 0x02,   18 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QUrl,   13,
    0x80000000 | 15,

 // properties: name, type, flags, notifyId, revision
      16, QMetaType::Bool, 0x00015903, uint(0), 0,
      17, QMetaType::QString, 0x00015001, uint(1), 0,
      18, QMetaType::QString, 0x00015001, uint(1), 0,
      19, QMetaType::LongLong, 0x00015001, uint(1), 0,
      20, QMetaType::QString, 0x00015001, uint(1), 0,
      21, QMetaType::Float, 0x00015903, uint(2), 0,
      22, QMetaType::Float, 0x00015903, uint(3), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject MusicPlayer::staticMetaObject = { {
    QMetaObject::SuperData::link<QMediaPlayer::staticMetaObject>(),
    qt_meta_stringdata_CLASSMusicPlayerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSMusicPlayerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_metaTypeArray<
        // property 'isPaused'
        bool,
        // property 'name'
        QString,
        // property 'artist'
        QString,
        // property 'duration'
        qint64,
        // property 'coverImage'
        QString,
        // property 'volume'
        float,
        // property 'lastVolume'
        float,
        // Q_OBJECT / Q_GADGET
        MusicPlayer,
        // method 'isPausedChanged'
        void,
        // method 'metaDataChanged'
        void,
        // method 'volumeChanged'
        void,
        // method 'lastVolumeChanged'
        void,
        // method 'onInitializationDone'
        void,
        // method 'm_play'
        void,
        // method 'm_pause'
        void,
        // method 'm_stop'
        void,
        // method 'm_setSource'
        void,
        const QUrl &,
        // method 'getMetaData'
        QMediaMetaData
    >,
    nullptr
} };

void MusicPlayer::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MusicPlayer *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->isPausedChanged(); break;
        case 1: _t->metaDataChanged(); break;
        case 2: _t->volumeChanged(); break;
        case 3: _t->lastVolumeChanged(); break;
        case 4: _t->onInitializationDone(); break;
        case 5: _t->m_play(); break;
        case 6: _t->m_pause(); break;
        case 7: _t->m_stop(); break;
        case 8: _t->m_setSource((*reinterpret_cast< std::add_pointer_t<QUrl>>(_a[1]))); break;
        case 9: { QMediaMetaData _r = _t->getMetaData();
            if (_a[0]) *reinterpret_cast< QMediaMetaData*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (MusicPlayer::*)();
            if (_t _q_method = &MusicPlayer::isPausedChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (MusicPlayer::*)();
            if (_t _q_method = &MusicPlayer::metaDataChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (MusicPlayer::*)();
            if (_t _q_method = &MusicPlayer::volumeChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (MusicPlayer::*)();
            if (_t _q_method = &MusicPlayer::lastVolumeChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<MusicPlayer *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->getIsPaused(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->name(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->artist(); break;
        case 3: *reinterpret_cast< qint64*>(_v) = _t->duration(); break;
        case 4: *reinterpret_cast< QString*>(_v) = _t->coverImage(); break;
        case 5: *reinterpret_cast< float*>(_v) = _t->volume(); break;
        case 6: *reinterpret_cast< float*>(_v) = _t->getLastVolume(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<MusicPlayer *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setIsPaused(*reinterpret_cast< bool*>(_v)); break;
        case 5: _t->setVolume(*reinterpret_cast< float*>(_v)); break;
        case 6: _t->setLastVolume(*reinterpret_cast< float*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *MusicPlayer::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MusicPlayer::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSMusicPlayerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QMediaPlayer::qt_metacast(_clname);
}

int MusicPlayer::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMediaPlayer::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 10;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    }
    return _id;
}

// SIGNAL 0
void MusicPlayer::isPausedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void MusicPlayer::metaDataChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void MusicPlayer::volumeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void MusicPlayer::lastVolumeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
