library(shiny)
library(argonDash)
library(argonR)
library(shinyjs)
library(shinythemes)
library(shinyauthr)
library(shiny)

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
                         icon = icon("th-large"),
                         icon_color = "primary",
                         "Beranda"
                       ),
                       argonSidebarItem(
                         tabName = "tabs",
                         icon = argonIcon(name="books", color = "info"),
                         verify_fa = FALSE,
                         "Profil Mahasiswa"
                       ),
                       argonSidebarItem(
                         tabName = "alerts",
                         icon = argonIcon(name="trophy", color = "success"),
                         verify_fa = FALSE,
                         "Penilaian"
                       ),
                       argonSidebarItem(
                         tabName = "images",
                         icon = argonIcon(name="ruler-pencil", color = "warning"),
                         verify_fa = FALSE,
                         "Presensi Kegiatan"
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
                       )#,
                       # argonSidebarItem(
                       #   tabName = "effects",
                       #   icon = "atom",
                       #   icon_color = "black",
                       #   "CSS effects"
                       # ),
                       # argonSidebarItem(
                       #   tabName = "sections",
                       #   icon = "credit-card",
                       #   icon_color = "grey",
                       #   "Sections"
                       # )
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
