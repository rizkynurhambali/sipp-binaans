library(shiny)
library(argonDash)
library(argonR)
library(shinyjs)
library(shinythemes)
library(shinyauthr)
library(shinymanager)

inactivity <- "function idleTimer() {
var t = setTimeout(logout, 120000);
window.onmousemove = resetTimer; // catches mouse movements
window.onmousedown = resetTimer; // catches mouse movements
window.onclick = resetTimer;     // catches mouse clicks
window.onscroll = resetTimer;    // catches scrolling
window.onkeypress = resetTimer;  //catches keyboard actions

function logout() {
window.close();  //close the window
}

function resetTimer() {
clearTimeout(t);
t = setTimeout(logout, 120000);  // time is in milliseconds (1000 is 1 second)
}
}
idleTimer();"

# data.frame with credentials info
credentials <- data.frame(
  user = c("admin", "kestari", "gda", "sr"),
  password = c("admin", "kestari", "gda", "sr"),
  # comment = c("alsace", "auvergne", "bretagne"), %>% 
  stringsAsFactors = FALSE
)

ui <- secure_app(head_auth = tags$script(inactivity),
                 argonDashPage(
                   title = "SIPP-BINAAN'S",
                   author = "Kelompok 2",
                   description = "Institut Pertanian Bogor",
                   sidebar = argonDashSidebar(
                     vertical = TRUE,
                     skin = "light",
                     background = "white",
                     size = "lg",
                     side = "left",
                     id = "my_sidebar",
                     # h1("Departemen Statistika"),
                     brand_url = "https://www.ipb.ac.id",
                     brand_logo = "images/logoipb.png",
                     # argonDashHeader("Menu"),
                     argonSidebarMenu(
                       argonSidebarItem(
                         tabName = "home",
                         icon = argonIcon("tv-2"),
                         icon_color = "primary",
                         "Beranda"
                       ),
                       argonSidebarItem(
                         tabName = "hadir",
                         icon = argonIcon(name="books", color = "info"),
                         verify_fa = FALSE,
                         "Kehadiran"
                       ),
                       argonSidebarItem(
                         tabName = "aktif",
                         icon = argonIcon(name="active-40", color = "success"),
                         verify_fa = FALSE,
                         "Keaktifan"
                       ),
                       argonSidebarItem(
                         tabName = "langgar",
                         icon = argonIcon(name="fat-remove", color = "warning"),
                         verify_fa = FALSE,
                         "Pelanggaran"
                       ),
                       argonSidebarItem(
                         tabName = "rekap",
                         icon = argonIcon(name="trophy", color = "warning"),
                         verify_fa = FALSE,
                         "Rekapitulasi"
                       ),
                       argonSidebarDivider(),
                       argonSidebarDivider(),
                       argonSidebarDivider(),
                       argonSidebarItem(
                         tabName = "badges",
                         icon = argonIcon(name="circle-08", color = "default"),
                         verify_fa = FALSE,
                         "Admin"
                       ),
                       argonSidebarItem(
                         tabName = "profile",
                         icon = argonIcon(name="spaceship", color = "default"),
                         verify_fa = FALSE,
                         "Tim Penyusun"
                       )
                     )
                   ),
                   navbar = argonDashNavbar(
                     argonRow(
                       img(src = "images/asrama-pku.png", width = "10%", height = "10%"),
                       h1(HTML("Asrama PKU IPB"), style = "color:white;font-weight:bold;font-size:220%;")
                     )
                   ),
                   header = argonDashHeader(
                     gradient = TRUE,
                     color = "primary",
                     separator = TRUE,
                     separator_color = "secondary"
                   ),
                   body = argonDashBody(
                     useShinyjs(),
                     tags$head(tags$link(rel = "shortcut icon", href = "images/asrama-pku.png")),
                     argonTabItems(
                       argonTabItem(
                         tabName = "home",
                         argonRow(
                           h1("Introducing SIPP BINAAN'S"),
                           p("SIPP-BINAAN'S adalah aplikasi sistem pusat penilaian insan Asrama yang 
                              berfungsi untuk memudahkan perhitungan penilaian binaan asrama PKU IPB.
                              Aplikasi ini dilatarbelakangi karena manjemen pendataan IPP asrama PKU IPB manual,
                              hal ini sangat kurang sistematis dan kurang terintegrasi")
                         ),
                         argonRow(
                           argonColumn(
                             width = 12,
                             argonH1("Filter by:", display = 4),
                             argonTabSet(
                               id = "filter",
                               card_wrapper = TRUE,
                               horizontal = TRUE,
                               circle = FALSE,
                               size = "sm",
                               width = 12,
                               iconList = lapply(X = 1:4, FUN = argonIcon, name = "bold-right"),
                               argonTab(
                                 tabName = "NIM",
                                 active = FALSE
                               ),
                               argonTab(
                                 tabName = "Jenis Kelamin",
                                 active = FALSE
                               ),
                               argonTab(
                                 tabName = "Gedung",
                                 active = TRUE
                               )
                             )
                           )
                         )
                       ),
                       argonTabItem(
                         tabName = "hadir",
                         argonRow(
                           h1("Kehadiran")
                         ),
                         argonRow(
                           argonColumn(
                             width = 12,
                             argonH1(display = 4),
                             argonTabSet(
                               id = "Kegiatan",
                               card_wrapper = FALSE,
                               horizontal = TRUE,
                               circle = FALSE,
                               size = "sm",
                               width = 12,
                               iconList = lapply(X = 1:4, FUN = argonIcon, name = "bold-right"),
                               argonTab(
                                 tabName = "Be New Family (BNF)",
                                 active = FALSE,
                                 argonRow(
                                   p("Be New Family merupakan kegiatan ...")
                                 )
                               ),
                               argonTab(
                                 tabName = "Social Gathering Lorong",
                                 active = FALSE,
                                 argonRow(
                                   p("Social Gathering Lorong merupakan kegiatan bersosialisai antar insan asrama 
                                     dalam lingkup lorong tertentu.")
                                 )
                               ),
                               argonTab(
                                 tabName = "Social Gathering Gedung",
                                 active = TRUE,
                                 argonRow(
                                   p("Social Gathering Gedung merupakan kegiatan bersosialisai antar insan asrama 
                                     dalam lingkup gedung tertentu.")
                                 )
                               ),
                               argonTab(
                                 tabName = "Hari Bersih Asrama",
                                 active = FALSE,
                                 argonRow(
                                   p("Hari Bersih Asrama merupakan kegiatan kerja bakti untuk menjaga kebersihan
                                     lingkungan asrama.")
                                 )
                               )
                             )
                           )
                         )
                       ),
                       argonTabItem(
                         tabName = "aktif",
                         argonRow(
                           h1("Pengaruh Keaktifan Terhadap Nilai AKhir"),
                           p("Keaktifan insan asrama memiliki kontribusi terhadap nilai akhir dan dihitung selama
                           periode masa asrama. Adapun persentasenya sebesar 10%.")
                         ),
                         argonRow(
                           argonColumn(
                             width = 16,
                             argonH1("Filter by:", display = 4),
                             argonTabSet(
                               id = "filter",
                               card_wrapper = TRUE,
                               horizontal = TRUE,
                               circle = FALSE,
                               size = "sm",
                               width = 12,
                               iconList = lapply(X = 1:4, FUN = argonIcon, name = "bold-right"),
                               argonTab(
                                 tabName = "Gedung",
                                 active = FALSE
                               ),
                               argonTab(
                                 tabName = "Lorong",
                                 active = FALSE
                               )
                             )
                           )
                         )
                       ),
                       argonTabItem(
                         tabName = "langgar",
                         argonRow(
                           h1("Pelanggaran"),
                           p("Pelanggaran terbagi menjadi tiga kategori, yaitu pelanggaran ringan, sedang, dan berat. 
                           Pelanggaran ringan menyebabkan pengurangan nilai akhir sebesar 1%. 
                           Pelanggaran sedang menyebabkan pengurangan nilai akhir sebesar 5%.
                           Pelanggaran berat menyebabkan pengurangan nilai akhir sebesar 10%.")
                         ),
                         argonRow(
                           argonColumn(
                             width = 16,
                             argonH1("Filter by:", display = 4),
                             argonTabSet(
                               id = "filter",
                               card_wrapper = TRUE,
                               horizontal = TRUE,
                               circle = FALSE,
                               size = "sm",
                               width = 12,
                               iconList = lapply(X = 1:4, FUN = argonIcon, name = "bold-right"),
                               argonTab(
                                 tabName = "Gedung",
                                 active = FALSE
                               ),
                               argonTab(
                                 tabName = "Lorong",
                                 active = FALSE
                               )
                             )
                           )
                         )
                       ),
                       argonTabItem(
                         tabName = "rekap",
                         argonRow(
                           h1("Rekapitulasi"),
                           p("Persentase kehadiran terhadap nilai akhir adalah sebesar 90%.
                             Persentase keaktifan terhadap nilai akhir adalah sebesar 10%.
                             Sedangkan, pelanggaran mengakibatkan pengurangan nilai akhir sebesar persentase kumulatif pelanggaran yang dilakukan insan asrama.")
                         ),
                         argonRow(
                           argonColumn(
                             width = 16,
                             argonH1("Filter by:", display = 4),
                             argonTabSet(
                               id = "filter",
                               card_wrapper = TRUE,
                               horizontal = TRUE,
                               circle = FALSE,
                               size = "sm",
                               width = 12,
                               iconList = lapply(X = 1:4, FUN = argonIcon, name = "bold-right"),
                               argonTab(
                                 tabName = "Gedung",
                                 active = FALSE
                               ),
                               argonTab(
                                 tabName = "Lorong",
                                 active = FALSE
                               ),
                               argonTab(
                                 tabName = "Nilai"
                               )
                             )
                           )
                         )
                       )
                     )
                   )
                 )
)
                 


server <- function(input, output, session) {
  
  result_auth <- secure_server(check_credentials = check_credentials(credentials))
  
  output$res_auth <- renderPrint({
    reactiveValuesToList(result_auth)
  })
  
}
# Run the application 
shinyApp(ui = ui, server = server)
