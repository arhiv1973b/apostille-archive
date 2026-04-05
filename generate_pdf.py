from reportlab.lib import colors
from reportlab.lib.pagesizes import A4, landscape
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet

def create_pdf():
    doc = SimpleDocTemplate("Actor_Apostille_Archive_EN.pdf", pagesize=landscape(A4))
    elements = []
    styles = getSampleStyleSheet()
    data = [["No", "Apostille ID", "Security Code", "Signatory", "Date", "Status"]]
    
    # Твои данные из промпта
    raw_data = [
        ("1","IMWM44AZGX6N6","2013073817848","Toporets Irina","18.01.2021"), ("2","BOUS9XAQDTFH2","2013073851064","Miron Aliona","24.02.2021"),
        ("3","CQ0VC27VGTCK6","2013073880545","Gonza Natalia","29.03.2021"), ("4","DR4Y1584JW9F4","2013073886585","Miron Aliona","05.04.2021"),
        ("5","7H2Q3790FZEI5","2013073926618","Miron Aliona","18.05.2021"), ("6","5GTUD58SJQ5N6","2013073928629","Guzun Corneliu","19.05.2021"),
        ("7","9OVS71FRKM4S3","2013073942632","Stela Pynzaru","02.06.2021"), ("8","7G6YCW5R9NCP4","2013073967178","Toma Nadezhda","25.06.2021"),
        ("9","9T3M953ZBUHO4","2013073967857","Guzun Corneliu","25.06.2021"), ("10","4O2V205Z9TCG2","2013073973599","Galben Anatolii","02.07.2021"),
        ("11","3R3T11BQ6TJI1","2013073973599","Guzun Corneliu","02.07.2021"), ("12","8I2N14CVELIQ5","2013073980269","Guzun Corneliu","08.07.2021"),
        ("14","HS5N558YBNEK3","2013074004858","Georghii Nikolaesku","26.07.2021"), ("15","COUQ976XEZCH7","2013074010279","Volentir Andrei","30.07.2021"),
        ("16","DLUX84ASKYII6","2013074013836","Pushkutsa Sergey","03.08.2021"), ("17","7FYS428VLM4F4","2013074021602","Muntyanu Dorin","09.08.2021"),
        ("18","FN5P1X6ZIP6R3","2013074048357","Melintyanu Yuri","24.08.2021"), ("19","3HWVD912FN7H4","2013074053054","Feldman Yan","26.08.2021"),
        ("20","BO2TCZ6WHSFG4","2013074052736","Kurov Igor","26.08.2021"), ("21","5G2T615VCPFG1","2013073969189","Iordan Yuri","28.06.2021"),
        ("22","IG4Q770QDXGH7","2013074184369","Toma Nadezhda","22.12.2021"), ("23","EJ3U9703FPFS4","2013074155734","Toma Nadejda","18.11.2021"),
        ("24","CTTO324Z8MDO7","2013074147166","Vasilii Stakhurskii","10.11.2021"), ("25","9J3V97AV8T4M8","2013074147166","Vasilii Stakhurskii","10.11.2021"),
        ("26","6QTV0Z4VIS7I1","2013074130885","Feldman Yan","27.10.2021"), ("27","FRWX11FTJU5F9","2013074190032","Potinga Vyacheslav","29.12.2021"),
        ("28","CFYN438ZLLFN2","2013074127359","Iordan Yuri","25.10.2021"), ("29","CK5O133ZKLJE8","2013074127359","Iordan Yuri","25.10.2021"),
        ("30","5S2WF92X7X4R8","2013074079955","Miron Aliona","16.09.2021"), ("31","DOYO489SCL5K2","2013074137051","Katana Angel","02.11.2021"),
        ("32","6R3U2Y63JZ6M3","2013073928629","Guzun Corneliu","19.05.2021"), ("33","3S6V078ZELJK9","2013073928629","Guzun Corneliu","19.05.2021"),
        ("34","CH3OF03S9Q7F9","2013074286896","Ciubotaru Lorina","22.03.2022"), ("35","5OTZ38FVFN8R2","2013074190032","Iordan Iurie","29.12.2021"),
        ("36","DLTP7B8ZHWGQ7","2013074484667","unclear signature","08.07.2022"), ("37","7R0W7XAY9OFH2","2013074469061","Sacenco Valentina","04.07.2022"),
        ("38","BO1SF0EV8U6P7","2013073999025","Parasca Vasile","21.07.2021"), ("39","3RX0DXD1DOFL2","2013074538582","Falca Vitalie","03.08.2022"),
        ("40","DQWVCZCRGYBP4","2013074013836","Stambol Tudor","03.08.2021"), ("41","CG0T6Y1TBUEL7","2013074491511","unclear signature","12.07.2022"),
        ("42","GGTUEBEZGYGH7","2013074155734","Diaconu Iurie","18.11.2021"), ("43","3QWY79726SDN4","2013073987916","Iordan Iurie","14.07.2021"),
        ("44","FJXU588SHPDP2","2013074127359","Iordan Iurie","25.10.2021"), ("45","5L7N238Z7QHH5","2013074147166","Gheorghe Nicolaescu","10.11.2021"),
        ("46","IPTZ514SCO6R9","2013074007644","Guzun Corneliu","28.07.2021"), ("47","7G6OCX9YIR8K7","2013074013836","Tatiana Ivanicichina","03.08.2021"),
        ("48","CI6P9821GWFR5","2013074232763","Cotruta Ecaterina","07.02.2022"), ("49","HFUO1X3XGUDF7","2013074538582","Falca Vitalie","03.08.2022"),
        ("50","GS5T609ZFL4E3","2013074077739","Curov Igor","15.09.2021"), ("51","5J1095ARLQJN5","2013073986643","Girbu Silvia","13.07.2021"),
        ("52","6LTO0B9ZBV7N3","2013073987916","Turcanu Radu","14.07.2021"), ("53","DJ6Z0130LM7H2","2013074130649","Toma Nadejda","27.10.2021"),
        ("54","6H0S225X9UFN2","2013074914782","Ciocan Diana","07.02.2023"), ("55","FPWSB4ARCR9L3","2013074232763","Cotruta Ecaterina","07.02.2022"),
        ("56","FL2VB340JYEG5","2013073998714","Miron Aliona","21.07.2021"), ("58","CT5X1Y51KUDM1","2013074286896","Dimitriu Serghei","22.03.2022"),
        ("59","GO5V1W1R7XCF7","2013074127359","Iordan Iurie","25.10.2021"), ("60","IJ1S0403JYEH8","2013073967857","Cojocari Elena","25.06.2021"),
        ("61","8Q0V733ZLQFO7","2013073978518","Iordan Iurie","07.07.2021"), ("62","CO2S9BA3JX6H1","2013074301759","Trandafilova Maria","01.04.2022"),
        ("64","5PWVD5A28PBS8","2013073917111","Nicolau Natalia","07.05.2021"), ("65","80UQ636YBZG17","2013073978518","Iordan Iurie","07.07.2021"),
        ("67","6S1Q564XIRJJ8","2013074809675","Cernei Natalia","14.12.2022"), ("68","DFVMD2FQLW5N3","2013074809675","unclear signature","14.12.2022"),
        ("69","IMTQ930Z8U4N7","2013074678387","unclear signature","05.10.2022"), ("70","HQ7X9W62GUJL9","2013074330087","unclear signature","20.04.2022"),
        ("71","BS7XCZF1EUJG3","2013074500114","unclear signature","15.07.2022"), ("72","EJ2077249VEH8","2013074821707","Gorincioi Stelian","21.12.2022"),
        ("73","EL3X827SBY4J0","2013074914782","Alexandru Doni","07.02.2023"), ("75","6J4V25F3DNGJ8","2013075043849","Casiadi Maria","18.04.2023"),
        ("76","HI4O379ZEPGN2","2013074469061","Cobzac Elena","04.07.2022"), ("77","403WF02QGRCI1","2013074897031","unclear signature","30.01.2023"),
        ("78","IQVY40CXISHM2","2013075043962","Lungu Livia","18.04.2023"), ("79","DQ1N892ZFXDI3","2013074979347","unclear signature","13.03.2023"),
        ("80","3SUU150WIRBO8","2013075137333","Lungu Livia","03.07.2023"), ("81","DIV07B9RCV8P4","2013075137333","Ghiletchi Tatiana","03.07.2023"),
        ("82","816030ASHY6M6","2013073998714","Miron Aliona","21.07.2021"), ("83","DI6RDB72JYDL1","2013074139147","Voloh Mariana","03.11.2021"),
        ("84","HS0W3X5SGO603","2013074683466","Gorincioi Stelian","2022"), ("85","6R2V5Z4XBZBH8","2013074509902","unclear signature","20.07.2022"),
        ("86","IT1PD8E29S5F5","2013074897031","unclear signature","30.01.2023"), ("87","EQ6RD50ZGP8MO","2013073967178","Daguta Sergiu","25.06.2021"),
        ("88","CQ5PF42YCMDO5","2013073913601","Nicolau Natalia","05.05.2021"), ("90","4J20E98WFY7J2","2013074672491","unclear signature","03.10.2022"),
        ("92","8OUWOZDQJZGQ2","2013074009846","Iavorschi Andrei","29.07.2021"), ("93","6OZUD89VBUEJ3","2013074732485","unclear signature","01.11.2022"),
        ("94","DOUM4B2ZHL7J7","2013075043849","Lungu Livia","18.04.2023"), ("95","9L5ZBB6SHU9K5","2013074469061","Butnaru Lilian","04.07.2022"),
        ("96","IHW093CZ8U8R7","2013074538582","unclear signature","03.08.2022"), ("97","EOYXD0FZ7Y8P2","2013074031106","Vinogradov Mihail","13.08.2021")
    ]

    for r in raw_data:
        status = "VOID" if "unclear" in r[3] else "ACTIVE"
        data.append([r[0], r[1], r[2], r[3], r[4], status])

    elements.append(Paragraph("A©tor: Apostille Registry — English Version", styles['Title']))
    elements.append(Spacer(1, 12))
    
    t = Table(data, repeatRows=1)
    style_list = [
        ('BACKGROUND', (0, 0), (-1, 0), colors.lightgrey),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
        ('FONTNAME', (0, 0), (-1, -1), 'Times-Roman'),
        ('FONTSIZE', (0, 0), (-1, -1), 8),
    ]
    
    # Подсветка VOID
    for i, row in enumerate(data):
        if row[5] == "VOID":
            style_list.append(('BACKGROUND', (0, i), (-1, i), colors.salmon))
            
    t.setStyle(TableStyle(style_list))
    elements.append(t)
    doc.build(elements)
    print("✅ PDF 'Actor_Apostille_Archive_EN.pdf' created with 90 entries.")

create_pdf()
