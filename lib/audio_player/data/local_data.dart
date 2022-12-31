import 'package:radio_ga/audio_player/data/models/audio_data.dart';
import 'package:radio_ga/audio_player/data/models/playlist.dart';

class LocalData {
  static List<Playlist> playlists = [
    Playlist(
        id: '0',
        album: 'icelandic_sagas',
        title: 'Скандинавия эпохи викингов',
        description:
            'Медиевист Федор Успенский — о том, как средневековые скандинавы жили дома, когда не грабили своих соседей',
        audioList: [
          AudioData(
              filename: '1.mp3', title: 'О чем рассказывают исландские саги'),
          AudioData(
              filename: '2.mp3',
              title: 'Власть и престолонаследие в средневековой Норвегии'),
          AudioData(
              filename: '3.mp3',
              title: 'Сага о конунге Норвегии Магнусе Добром'),
          AudioData(
              filename: '4.mp3',
              title: 'Сага о Гисли: как отомстить тому, кому мстить нельзя'),
          AudioData(
              filename: '5.mp3',
              title: 'Общество без власти в средневековой Исландии'),
          AudioData(filename: '6.mp3', title: 'Как крестилась Скандинавия'),
          AudioData(
              filename: '7.mp3', title: 'Сага об убийстве Снорри Стурлусона'),
        ]),
    Playlist(
      id: '2',
      album: 'proshloe',
      title: 'Proshloe исторический журнал',
      description:
          'Интервью с учеными о том, что происходит с исторической наукой прямо сейчас. Дискуссии о важном.',
      audioList: [
        AudioData(
            filename: 'the_great_migration_of peoples.m4a',
            title:
                'Великое переселение народов. Олег Радюш. Родина слонов № 154')
      ],
    ),
    Playlist(
      id: '1',
      album: 'economy_codes',
      title: 'Культурные коды экономики: почему страны живут по-разному',
      description:
          'Лекции Александра Аузана о том, как связаны экономика и культура, почему некоторые нации маскулинные, а другие феминные, зачем доверять друг другу и где России искать свое экономическое чудо',
      audioList: [
        AudioData(filename: '1.mp3', title: 'Зачем экономике культура'),
        AudioData(
            filename: '2.mp3',
            title: 'Как связаны экономический успех и религия'),
        AudioData(
            filename: '3.mp3',
            title: 'Как на успешность нации влияют язык, климат и история'),
        AudioData(
            filename: '4.mp3',
            title:
                'Почему Россия — биполярная страна и что это значит для нашей экономики'),
        AudioData(
            filename: '5.mp3',
            title: '«Авось», «небось» и другие возможности России'),
        AudioData(
            filename: '6.mp3',
            title: 'Можно ли менять культуру ради экономического роста'),
        AudioData(
            filename: '7.mp3',
            title: 'Доверие как источник экономического чуда'),
      ],
    ),
  ];
}
