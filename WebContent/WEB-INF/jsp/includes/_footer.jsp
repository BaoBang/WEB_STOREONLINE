<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <!-- END ./FOOTER -->
<div class="footer">
  <div class="container">
    <div class="row">
      <div class="col-md-8">
        <img src="${pageContext.request.contextPath}/themes/images/logo.png" alt="">  
      </div>
      <div class="col-md-4">
        
      </div>
    </div>
  </div>
</div>
    <div class="last-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12 text-center">
            <a href="#">
              <span class="copyright">© 2017 PTiT Shop  | Designed and Developed by Lê Văn Tâm & Nguyễn Bảo Bằng</span>
            </a>
          </div>  
        </div>
      </div>
    </div>  
<!-- END ./FOOTER -->

<!-- BACK TO TOP -->
<button class="btn btn-top" href="javascript:void(0);" title="Go To Top">
  <i class="fa fa-arrow-up rotate-360"></i>
</button>

<!-- jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath}/themes/js/jquery-3.2.1.min.js"></script>
<!-- Bootstrap -->
<script type="text/javascript" src="${pageContext.request.contextPath}/themes/js/bootstrap.min.js"></script>
<!-- carousel-->
<script type="text/javascript" src="${pageContext.request.contextPath}/themes/js/owl.carousel.min.js"></script>
<!-- Shop -->
<script type="text/javascript" src="${pageContext.request.contextPath}/themes/js/shop.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		//var x_timer;
		$("#input-search").on('keyup',function(e) {
			
		//	clearTimeout(x_timer);
			var input_data = $(this).val();
			search(input_data);
			
			
		});
		function search(input_data) {
			$.ajax({type : "POST",
						url : "${pageContext.request.contextPath}/ajax/search",
						data : {
							inputdata : input_data
						},
						success : function(result) {
							$('#search-result-main').html(result);
							var numberOfResultSearch = $('#number-of-result-search').text();
							$(".search-price").append("đ");
							$('#number-of-result-search').html("<h4>Có " + numberOfResultSearch +" sản phẩm được tìm thấy.</h4>");
						}
					});

		}
	});

</script>
