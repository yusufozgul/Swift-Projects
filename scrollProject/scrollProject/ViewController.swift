//
//  ViewController.swift
//  scrollProject
//
//  Created by Yusuf Özgül on 8.11.2018.
//  Copyright © 2018 Yusuf Özgül. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var slides:[Slide] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        scrollView.delegate = self
        
        slides = sliders()
        setScrollView(slides: slides)
        
//        Sayfa belirteçlerinin başlangıç ayarı
        pageController.numberOfPages = slides.count
        pageController.currentPage = 0
        view.addSubview(pageController)
        
//        Dikey kaydırmayı devre dışı bırakmak için
        self.scrollView.contentSize.height = 1.0
        
        
        
    }

//    Kaydırılabilir öğelerimizin bilgileri ve sayısı bbu fonksiyona girilmelidir
    func sliders() -> [Slide]
    {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "yivli.JPG")
        slide1.titleLabel.text = "Yivli Minare"
        slide1.descText.text = "Antalya Kalekapısı semtinde bulunan ve çok sayıda Selçuklu yapıtından oluşan eserler topluluğudur."
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "kursunlu.JPG")
        slide2.titleLabel.text = "Kurşunlu Şelalesi"
        slide2.descText.text = "Kurşunlu Şelalesi Tabiat Parkı Antalya'nın Aksu İlçesi sınırları içinde yer alan doğal güzelliği ile ziyaretçilerinin kendine hayran bıraktıran bir yerdir"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "duden.JPG")
        slide3.titleLabel.text = "Düden Şelalesi"
        slide3.descText.text = "Düden şelâlesi, Antalya'yı simgeleyen tabiat güzelliklerindendir. 20 metre yükseklikten dökülür. Ana kaynağı Kırkgöz mevkisidir"
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "termessos.JPG")
        slide4.titleLabel.text = "Termessos Milli Parkı"
        slide4.descText.text = "Antalya Korkuteli yolunun 12. km sinde sol tarafta Güllük Dağı Termessos Milli Parkı girişi, sağ tarafta ise Karain Mağarası yolu yer almaktadır. Aynı güzergahtan Antalya'ya dönerseniz dönüş de Güver Kanyonu (Güver uçurumu) Tabiat Parkına uğrayabilirsiniz."
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "perge.JPG")
        slide5.titleLabel.text = "Perge Antik Kenti"
        slide5.descText.text = "Antalya şehir merkezinin 17 km. doğusundaki, Aksu sınırları içinde yer alan Perge Antik Kenti, sadece bölgenin değil, tüm Anadolu'nun en düzenli Roma dönemi kentlerinden biridir."
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    
//    Scrollview bilgileri ve kaydırılabbilir öğelerin eklenmesi
    func setScrollView(slides: [Slide])
    {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        

        for i in 0 ..< slides.count
        {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
//    Sayfa belirteçleri ayarlamak için kullanılan fonksiyon
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageController.currentPage = Int(pageIndex)
        
//        Dikey durum
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
//        Yatay durum
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
//        Yatay ve dikey olarak kaçıncı scrollView'de olduğumuzu anlamak için bulunan view / maximum view
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)

        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.50, y: (0.75-percentOffset.x)/0.50)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        }else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.75, y: (1-percentOffset.x)/0.75)
            slides[4].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/1, y: percentOffset.x/1)
            
        }
    }
    
    

}

