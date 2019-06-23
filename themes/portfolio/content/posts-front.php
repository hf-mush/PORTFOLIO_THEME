<ul class="list list--articles">
<?php
$args = array(
    'posts_per_page' => 8,
    'offset' => 0,
    'category' => '',
    'category_name' => '',
    'orderby' => 'date',
    'order' => 'DESC',
    'include' => '',
    'exclude' => '',
    'meta_key' => '',
    'meta_value' => '',
    'post_type' => 'post',
    'post_mime_type' => '',
    'post_parent' => '',
    'author' => '',
    'post_status' => 'publish',
    'suppress_filters' => true,
);
$data = get_posts($args);
foreach ($data as $post) {
    setup_postdata($post);
    $image_url = get_the_post_thumbnail_url($post->ID, 'full');
    ?>
  <li class="list__item">
  <?php
if (!isset($image_url) || $image_url === false) {
        ?>
    <div class="item__thumbnail"><a class="thumbnail-link" href="<?php echo get_the_permalink($post->ID); ?>"></a></div>
    <?php
} else {
        ?>
    <div class="item__thumbnail" style="background-image:url('<?php echo $image_url; ?>');"><a class="thumbnail-link" href="<?php echo get_the_permalink($post->ID); ?>"></a></div>
    <?php
}
    ?>
    <div class="item__content">
      <!--<div class="title content__item-title"><a class="link" href="<?php echo get_the_permalink($post->ID); ?>"><?php echo mb_substr($post->post_title, 0, 20); ?></a></div>-->
      <div class="text extract"><?php echo get_the_excerpt($post->ID); ?></div>
      <!--<div class="text content__item-date"><?php echo get_the_time('Y.m.d', $post->ID) ?></div>-->
    </div>
  </li>
<?php
}
?>
</ul>
