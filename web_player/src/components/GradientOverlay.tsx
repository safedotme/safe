interface GradientOverlayProps {
  isDark: boolean;
}

const GradientOverlay = (props: GradientOverlayProps) => {
  return (
    <div
      className={`absolute bottom-0 h-[150px] w-screen bg-gradient-to-t  from-20% to-100% ${
        props.isDark
          ? "from-grey-700  to-grey-700/[0]"
          : "from-[#F0F0F0]  to-[#F0F0F0]/[0]"
      }`}
    />
  );
};

export default GradientOverlay;
