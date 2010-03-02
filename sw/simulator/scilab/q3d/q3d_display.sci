


function display_fdm()

  clf();
  global fdm_time;
  global fdm_state;

  subplot(2,3,1);
  plot2d(fdm_time, fdm_state(FDM_SX, :));
  xtitle('X');

  subplot(2,3,2);
  plot2d(fdm_time, fdm_state(FDM_SZ, :));
  xtitle('Z');

  subplot(2,3,3);
  plot2d(fdm_time, deg_of_rad(fdm_state(FDM_STHETA, :)));
  xtitle('Theta');

  subplot(2,3,4);
  plot2d(fdm_time, fdm_state(FDM_SXD, :));
  xtitle('Xd');

  subplot(2,3,5);
  plot2d(fdm_time, fdm_state(FDM_SZD, :));
  xtitle('Zd');

  subplot(2,3,6);
  plot2d(fdm_time, deg_of_rad(fdm_state(FDM_STHETAD, :)));
  xtitle('Thetad');
  
endfunction

function display_fo(time, fo)

  clf();
  
  subplot(5,2,1);
  plot2d(time, matrix(fo(1,1,:), 1, length(time)));
  xtitle('X(0)');

  subplot(5,2,2);
  plot2d(time, matrix(fo(2,1,:), 1, length(time)));
  xtitle('Z(0)');

  subplot(5,2,3);
  plot2d(time, matrix(fo(1,2,:), 1, length(time)));
  xtitle('X(1)');

  subplot(5,2,4);
  plot2d(time, matrix(fo(2,2,:), 1, length(time)));
  xtitle('Z(1)');

  subplot(5,2,5);
  plot2d(time, matrix(fo(1,3,:), 1, length(time)));
  xtitle('X(2)');

  subplot(5,2,6);
  plot2d(time, matrix(fo(2,3,:), 1, length(time)));
  xtitle('Z(2)');

  subplot(5,2,7);
  plot2d(time, matrix(fo(1,4,:), 1, length(time)));
  xtitle('X(3)');

  subplot(5,2,8);
  plot2d(time, matrix(fo(2,4,:), 1, length(time)));
  xtitle('Z(3)');

  subplot(5,2,9);
  plot2d(time, matrix(fo(1,5,:), 1, length(time)));
  xtitle('X(4)');

  subplot(5,2,10);
  plot2d(time, matrix(fo(2,5,:), 1, length(time)));
  xtitle('Z(4)');

endfunction


function display_commands(time, diff_flat_cmd)
  subplot(2,2,1);
  plot2d(time, diff_flat_cmd(1,:));
  xtitle('u1');

  subplot(2,2,2);
  plot2d(time, diff_flat_cmd(2,:));
  xtitle('u2');
  
  subplot(2,2,3);
  plot2d(time, diff_flat_cmd(1,:)-diff_flat_cmd(2,:));
  xtitle('F1');

  subplot(2,2,4);
  plot2d(time, diff_flat_cmd(1,:)+diff_flat_cmd(2,:));
  xtitle('F2');
  
  
endfunction


function display_fo_ref(time, diff_flat_ref)

  subplot(2,3,1);
  plot2d(time, diff_flat_ref(FDM_SX, :));
  xtitle('X');

  subplot(2,3,2);
  plot2d(time, diff_flat_ref(FDM_SZ, :));
  xtitle('Z');

  subplot(2,3,3);
  plot2d(time, deg_of_rad(diff_flat_ref(FDM_STHETA, :)));
  xtitle('Theta');

  subplot(2,3,4);
  plot2d(time, diff_flat_ref(FDM_SXD, :));
  xtitle('Xd');

  subplot(2,3,5);
  plot2d(time, diff_flat_ref(FDM_SZD, :));
  xtitle('Zd');

  subplot(2,3,6);
  plot2d(time, deg_of_rad(diff_flat_ref(FDM_STHETAD, :)));
  xtitle('Thetad');
  
endfunction

function display_control(time, diff_flat_ref, fdm_state, diff_flat_cmd, fb_cmd, motor_cmd );

  f=get("current_figure");
  f.figure_name="Control";

  clf();
  
  subplot(4,3,1);
  plot2d(time, diff_flat_ref(FDM_SX, :), 3);
  plot2d(time, fdm_state(FDM_SX, :), 2);
  legends(["fdm", "ref"],[2 3], with_box=%f, opt="ul"); 
  xtitle('X');

  subplot(4,3,2);
  plot2d(time, diff_flat_ref(FDM_SZ, :), 3);
  plot2d(time, fdm_state(FDM_SZ, :), 2);
  xtitle('Z');

  subplot(4,3,3);
  plot2d(time, deg_of_rad(diff_flat_ref(FDM_STHETA, :)), 3);
  plot2d(time, deg_of_rad(fdm_state(FDM_STHETA, :)), 2);
  xtitle('Theta');

  subplot(4,3,4);
  plot2d(time, diff_flat_ref(FDM_SXD, :), 3);
  plot2d(time, fdm_state(FDM_SXD, :), 2);
  xtitle('Xd');

  subplot(4,3,5);
  plot2d(time, diff_flat_ref(FDM_SZD, :), 3);
  plot2d(time, fdm_state(FDM_SZD, :), 2);
  xtitle('Zd');

  subplot(4,3,6);
  plot2d(time, deg_of_rad(diff_flat_ref(FDM_STHETAD, :)), 3);
  plot2d(time, deg_of_rad(fdm_state(FDM_STHETAD, :)), 2);
  xtitle('Thetad');
  
  
  subplot(4,2,5);
//  plot2d(time, diff_flat_cmd(1,:)+ fb_cmd(1,:), 5);
  xset("color",5);
  foo = diff_flat_cmd(1,:) + fb_cmd(1,:);
  xfpoly([time time($:-1:1)], [diff_flat_cmd(1,:) foo($:-1:1)]);
  xset("color",1);
  plot2d(time, diff_flat_cmd(1,:), 2);
  xtitle('u_t');

  subplot(4,2,6);
  tot_cmd = diff_flat_cmd(2,:) + fb_cmd(2,:);
  xset("color",5);
  xfpoly([time time($:-1:1)], [diff_flat_cmd(2,:) tot_cmd($:-1:1)]);
  xset("color",1);
  plot2d(time, diff_flat_cmd(2,:), 2);
  xtitle('u_d');
  
  subplot(4,2,7);
  plot2d(time, motor_cmd(1,:), 2);
  xtitle('u1');

  subplot(4,2,8);
  plot2d(time, motor_cmd(2,:), 2);
  xtitle('u2');
  
  
endfunction
