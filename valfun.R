#
# Functions for use in the validation project
#

# function for fuzzy matching station names and return of similar they are (#chars). 0=exact match
stn_match_fun<-function(a_dat, stn_reg){ # a_dat=all data from a file ("MUST" have column station_name)
                                  # stn_reg = station names definitions MUST have column "Namn"
  uniq_stn_names<-unique(as.character(a_dat$station_name))
  ok_stn_names<-stn_reg$Namn # allowed names

# store results here
  result_mat<-matrix(ncol=3, nrow=(length(uniq_stn_names)))
  colnames(result_mat)<-c("Reported station","Valid name","difference")

# use adist to calculate how similar each station name is to the allowed name. zero being exact match

  for(i in 1:length(uniq_stn_names)){ # similar to the python enumerate approach
    the_name<-uniq_stn_names[i]
    if(nchar(as.character(the_name))<1){
      the_name='WARNING Name missing somewhere!'
      result_mat[i,1]<-the_name
      result_mat[i,2]<-'well, a station name whould be nice'
      result_mat[i,3]<-':('
    }else{
      a_dists<-adist(the_name, ok_stn_names)
      index<-which(a_dists==min(a_dists))
      result_mat[i,1]<-as.character(uniq_stn_names[i])
      result_mat[i,2]<-as.character(ok_stn_names[index])
      result_mat[i,3]<-as.character(min(a_dists))
    }
  }
 return(result_mat)
}

