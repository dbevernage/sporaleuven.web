export interface HistoryPhoto {
  id: string;
  src: string;
  thumbnailSrc: string;
  thumbnailWidth: number;
  thumbnailHeight: number;
  caption: string;
  year?: number;
}

export const photos: HistoryPhoto[] = [
  { id: 'heren-1-2002-2003', src: '/images/history/Heren_1_2002_2003.jpg', thumbnailSrc: '/images/history/Heren_1_2002_2003-thumb.jpg', thumbnailWidth: 480, thumbnailHeight: 327, caption: 'Heren 1', year: 2002 },
  { id: 'heren-1-bekerwinst', src: '/images/history/Heren_1_bekerwinst.jpg', thumbnailSrc: '/images/history/Heren_1_bekerwinst-thumb.jpg', thumbnailWidth: 480, thumbnailHeight: 333, caption: 'Bekerwinst - vorige eeuw', year: 1996 },
  { id: 'heren-1-bekerwinst-2', src: '/images/history/Heren_1_bekerwinst_2.jpg', thumbnailSrc: '/images/history/Heren_1_bekerwinst_2-thumb.jpg', thumbnailWidth: 480, thumbnailHeight: 333, caption: 'Bekerwinst - vorige eeuw', year: 1996 },
  { id: 'heren-ouw-zakken-match-2019', src: '/images/history/Heren_OuwZakkenMatch_2019.JPG', thumbnailSrc: '/images/history/Heren_OuwZakkenMatch_2019-thumb.JPG', thumbnailWidth: 480, thumbnailHeight: 360, caption: 'Ouw Zakken Match', year: 2019 },
  { id: 'heren-ouw-zakken-match-2019-2', src: '/images/history/Heren_OuwZakkenMatch_2019_2.JPG', thumbnailSrc: '/images/history/Heren_OuwZakkenMatch_2019_2-thumb.JPG', thumbnailWidth: 480, thumbnailHeight: 360, caption: 'Ouw Zakken Match', year: 2019 }
];

export const fuifPhotos: HistoryPhoto[] = Array.from({ length: 43 }, (_, index) => ({
  id: `fuif-photo-${String(index + 1).padStart(2, '0')}`,
  src: `/images/history/Fuif/photo${String(index + 1).padStart(2, '0')}.jpg`,
  thumbnailSrc: `/images/history/Fuif/photo${String(index + 1).padStart(2, '0')}-thumb.jpg`,
  thumbnailWidth: index === 42 ? 360 : 480,
  thumbnailHeight: index === 42 ? 480 : 360,
  caption: 'Spora fuif - Zaal Pacem'
}));

export const allHistoryPhotos = [...photos, ...fuifPhotos];
const historyPhotoHrefById = new Map(
  allHistoryPhotos.map((photo, index) => [photo.id, `/history/images/${index + 1}`])
);

export function getHistoryPhotoHref(photo: HistoryPhoto) {
  const href = historyPhotoHrefById.get(photo.id);

  if (!href) {
    throw new Error(`Unknown history photo: ${photo.src}`);
  }

  return href;
}
